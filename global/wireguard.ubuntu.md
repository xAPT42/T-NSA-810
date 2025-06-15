
---

# 🛡️ README – WireGuard côté Serveur (Ubuntu)

Ce guide résume toutes les commandes pour configurer, démarrer et vérifier un serveur WireGuard accessible à distance.

---

## 📁 1. Créer la configuration serveur

Fichier à placer dans :

```bash
/etc/wireguard/wg0.conf
```

### Exemple de contenu :

```ini
[Interface]
PrivateKey = <clé_privée_du_serveur>
Address = 192.168.56.1/24
ListenPort = 51820

# Peer Mac
[Peer]
PublicKey = <clé_publique_du_mac>
AllowedIPs = 192.168.56.99/32
```

> ✅ Remplace les clés par celles générées avec `wg genkey`

---

## 🔐 2. Générer les clés

```bash
wg genkey | tee server-private.key | wg pubkey > server-public.key
```

---

## ✅ 3. Activer et démarrer WireGuard

```bash
sudo systemctl enable --now wg-quick@wg0
```

---

## 🔍 4. Vérifier l'état

```bash
sudo wg
```

Tu dois voir :

* l’interface `wg0`
* les clés
* la section `[Peer]` avec `latest handshake`
* le trafic envoyé/reçu

---

## 🌐 5. Activer le routage IP

```bash
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p
```

---

## 🔁 6. Ajouter la règle NAT (masquerade)

⚠️ Remplace `enp0s31f6` par ton interface réseau externe si différente.

```bash
iptables -t nat -A POSTROUTING -s 192.168.56.0/24 -o enp0s31f6 -j MASQUERADE
```

👉 Rends-la persistante :

```bash
apt install iptables-persistent -y
iptables-save > /etc/iptables/rules.v4
```

---

## 🛑 7. Arrêter WireGuard si besoin

```bash
sudo wg-quick down wg0
```

---

## 📦 Résumé des fichiers utilisés

| Fichier                   | Rôle                         |
| ------------------------- | ---------------------------- |
| `/etc/wireguard/wg0.conf` | Fichier de configuration VPN |
| `server-private.key`      | Clé privée du serveur        |
| `server-public.key`       | Clé publique à partager      |
| `/etc/sysctl.conf`        | Routage IP activé            |
| `/etc/iptables/rules.v4`  | NAT persistante pour le VPN  |

---


