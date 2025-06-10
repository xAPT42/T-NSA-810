# Réseau Proxmox Hetzner : vmbr0 (public) & vmbr1 (privé)

## 1. Contexte

| Élément | Valeur |
|---------|--------|
| **Hôte** | Serveur dédié Hetzner – IP publique : **167.235.118.227** |
| **Hyperviseur** | Proxmox VE 8.4 |
| **Bridge existant** | `vmbr0` – lié à l’interface physique `enp0s31f6` |
| **Bridge à créer** | `vmbr1` – *sans* port physique (LAN privé `192.168.56.0/24`) |

Objectif : isoler les services internes (Web, API, DB, Monitoring) sur un réseau privé tout en laissant l’hôte (et, si besoin, un reverse‑proxy) exposé sur Internet.

---

## 2. Schéma topo‑logique

```
              Internet
                 │
        +--------┴---------+
        │  vmbr0  (public) │  ← 167.235.118.227/26
        │  Proxmox hôte    │
        +--------┬---------+
                 │ WG (UDP 51820)
     ┌───────────┴───────────────────────────────────────────────┐
     │                 vmbr1  (privé 192.168.56.0/24)            │
     │    ┌──────────┬──────────┬──────────┬──────────┐          │
     │    │  Web     │  API     │   DB     │Monitoring│          │
     │    │56.10     │56.20     │56.30     │56.40     │          │
     │    └──────────┴──────────┴──────────┴──────────┘          │
     └───────────────────────────────────────────────────────────┘
                       ▲
                       │
                 Kali VM (Mac) ── WireGuard ──► 192.168.56.99
```

---

## 3. Pourquoi **`vmbr1`** ?

| Critère | Tout sur `vmbr0` | Séparation `vmbr0` / `vmbr1` |
|---------|-----------------|-------------------------------|
| Surface d’attaque | Chaque service peut être exposé par erreur. | Services internes jamais routés vers Internet. |
| Zonage | Aucune frontière claire. | DMZ (vmbr0) ↔ LAN (vmbr1). |
| Pare‑feu | Règles complexes, trafic mélangé. | Règles simples : *public* vs *privé*. |
| MAC/Hetzner | Une seule MAC autorisée → bricolage. | Le LAN ne sort pas, pas de contrainte. |
| Red Team | Besoin de port‑forward multiples. | WireGuard donne un accès natif au LAN. |

---

## 4. Mise en place pas à pas

### 4.1 Création de `vmbr1`

```bash
# Sur l’hôte Proxmox
cat >> /etc/network/interfaces <<'EOF'

auto vmbr1
iface vmbr1 inet static
    address 192.168.56.1/24
    bridge_ports none
    bridge_stp off
    bridge_fd 0
EOF

ifreload -a   # ou redémarrage du service réseau
```

> **GUI :** *Datacenter ▸ Node ▸ System ▸ Network ▸ Create ▸ Linux Bridge*.

### 4.2 Brancher les VMs

| VM | ID | CPU | RAM | Disk | Interface |
|----|----|-----|-----|------|-----------|
| Web        | 102 | 1 | 2 GiB | 20 GB | `net0=virtio,bridge=vmbr1` |
| API        | 103 | 1 | 2 GiB | 20 GB | idem |
| DB         | 104 | 2 | 4 GiB | 40 GB | idem |
| Monitoring | 105 | 1 | 1 GiB | 10 GB | idem |

Configurer une IP statique dans chaque VM (`/etc/netplan`, `nmcli`, ou DHCP interne).

### 4.3 NAT sortant (apt update)

```bash
# Activer le forwarding une fois pour toutes
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# NAT pour le LAN privé
iptables -t nat -A POSTROUTING -s 192.168.56.0/24 -o vmbr0 -j MASQUERADE
```
> Pour la persistance : `apt install iptables-persistent`.

### 4.4 WireGuard (accès Kali)

1. **Hôte (Proxmox)**  
   ```bash
   apt install wireguard
   wg genkey | tee /root/server.key | wg pubkey > /root/server.pub
   ```
   Crée `/etc/wireguard/wg0.conf` :
   ```
   [Interface]
   Address = 192.168.56.1/24
   ListenPort = 51820
   PrivateKey = <server.key>

   [Peer]
   PublicKey = <kali.pub>
   AllowedIPs = 192.168.56.99/32
   ```
   `systemctl enable --now wg-quick@wg0`

2. **Kali (Mac)**  
   ```
   sudo apt install wireguard-tools
   wg genkey | tee kali.key | wg pubkey > kali.pub
   ```
   `wg0.conf` :
   ```
   [Interface]
   Address = 192.168.56.99/32
   PrivateKey = <kali.key>

   [Peer]
   PublicKey = <server.pub>
   Endpoint = 167.235.118.227:51820
   AllowedIPs = 192.168.56.0/24
   PersistentKeepalive = 25
   ```
   `sudo wg-quick up wg0`

---

## 5. Bonnes pratiques de sécurité

1. **Pare‑feu Proxmox**  
   - Autoriser uniquement SSH (22/tcp), Proxmox WebUI (8006/tcp) et WireGuard (51820/udp).  
2. **Fail2ban** sur l’hôte.  
3. **Accès root SSH désactivé** (`PermitRootLogin no`).  
4. **Backups** réguliers des VMs (`vzdump` + stockage externe).  
5. **Reverse‑proxy** (Nginx/Traefik) si tu exposes le service Web, avec TLS Let’s Encrypt.

---

## 6. Checklist rapide

- [ ] `vmbr1` créé et actif  
- [ ] VMs reliées, IPs internes configurées  
- [ ] NAT sortant fonctionnel  
- [ ] WireGuard opérationnel entre Kali et LAN  
- [ ] Pare‑feu minimaliste validé  
- [ ] Documentation saved as **README.md** ✅

---

