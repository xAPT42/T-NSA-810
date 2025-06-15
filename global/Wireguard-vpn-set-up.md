# 🛡️ Tutoriel : Création d'un Serveur WireGuard (Ubuntu)

Ce guide explique comment mettre en place un serveur WireGuard sécurisé sur Ubuntu pour permettre des connexions VPN clients (par exemple, depuis un Mac ou une VM Kali).

---

## 📅 Prérequis

* Un serveur Ubuntu avec une adresse IP publique (ex. Hetzner)
* Accès root via SSH
* Un client (MacOS ou Kali) avec WireGuard installé

---

## ✅ Étapes à suivre sur le serveur

### 1. ⚙️ Installer WireGuard

```bash
apt update && apt install wireguard -y
```

---

### 2. 🔐 Générer une paire de clés sécurisées

> Avant de créer les clés, applique un `umask` strict :

```bash
mkdir -p /etc/wireguard
cd /etc/wireguard
umask 077

wg genkey | tee server-private.key | wg pubkey > server-public.key
```

#### Pourquoi `umask 077` ?

* Cette commande **restreint les permissions** des fichiers créés à `600`
* ❌ Sans elle, la clé privée pourrait être lisible par d'autres utilisateurs (faille sécurité)
* ✅ Avec `umask 077` : seul root peut lire la clé privée

---

### 3. 🗋 Créer le fichier de configuration WireGuard

```bash
nano /etc/wireguard/wg0.conf
```

Exemple :

```ini
[Interface]
PrivateKey = <CLÉ_PRIVÉE_DU_SERVEUR>
Address = 192.168.56.1/24
ListenPort = 51820

[Peer]
PublicKey = <CLÉ_PUBLIQUE_DU_CLIENT>
AllowedIPs = 192.168.56.99/32
```

---

### 4. ⚖️ Activer le routage IP et le NAT

```bash
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -s 192.168.56.0/24 -o enp0s31f6 -j MASQUERADE
```

> Remplace `enp0s31f6` par ton interface réseau (vérifie avec `ip a`)

---

### 5. ▶️ Lancer et activer WireGuard

```bash
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
```

---

## ✉️ Ajouter un nouveau client

* Récupère la **clé publique** du client (générée sur Mac/Kali)
* Ajoute-la dans le fichier `wg0.conf` du serveur sous `[Peer]`

---

## ✉️ Infos utiles

### Tester la connectivité depuis le client :

```bash
ping 192.168.56.1       # IP du serveur VPN
ping 192.168.56.10      # Une VM sur le réseau interne
```

---

## 📄 Fichiers typiques

```bash
/etc/wireguard/
├── server-private.key  ➔ à garder secret
├── server-public.key   ➔ à partager avec les clients
└── wg0.conf            ➔ configuration principale du tunnel
```

---

## ⚡ Résumé rapide des commandes clés

```bash
apt install wireguard -y
umask 077
wg genkey | tee server-private.key | wg pubkey > server-public.key
nano /etc/wireguard/wg0.conf
sysctl -p
iptables -t nat -A POSTROUTING -s 192.168.56.0/24 -o <interface> -j MASQUERADE
systemctl enable --now wg-quick@wg0
```
