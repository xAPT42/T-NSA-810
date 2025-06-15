## differentes commande type dans le server distant ubuntu


```bash
setxkbmap fr
```
VirtualBox &

```bash
setxkbmap fr
```




## 📂 Structure attendue

Ton fichier de configuration client (`mac-to-lab.conf`) doit se trouver ici :

```bash
~/wireguard-kali/mac-to-lab.conf
```

---

## 🔑 Fichiers requis

* `kali-private.key` → ta clé privée
* `kali-public.key` → ta clé publique
* `mac-to-lab.conf` → configuration WireGuard contenant les IP et clés

---

## ✅ 1. Lancer le VPN

```bash
sudo wg-quick up ~/wireguard-kali/mac-to-lab.conf
```

> Cela :
>
> * crée l’interface VPN (`utunX`)
> * attribue l’IP locale (ex: `192.168.56.99`)
> * établit un tunnel sécurisé vers ton serveur Ubuntu

---

## 🧪 2. Vérifier que le tunnel est actif

```bash
ifconfig utun5
```

> Tu devrais voir :
>
> ```
> inet 192.168.56.99 --> 192.168.56.99
> ```

---

## 🧠 3. Tester la connectivité

Ping du serveur WireGuard distant :

```bash
ping 192.168.56.1
```

Ping d'une VM dans ton lab :

```bash
ping 192.168.56.10
```

---

## 🛑 4. Arrêter le VPN proprement

```bash
sudo wg-quick down ~/wireguard-kali/mac-to-lab.conf
```

---

## 🔐 5. Sécuriser le fichier de config (une seule fois)

```bash
chmod 600 ~/wireguard-kali/mac-to-lab.conf
```

---

## 📘 Exemple de fichier `mac-to-lab.conf`

```ini
[Interface]
PrivateKey = <clé_privée_mac>
Address = 192.168.56.99/24

[Peer]
PublicKey = <clé_publique_serveur>
Endpoint = 167.235.118.227:51820
AllowedIPs = 192.168.56.0/24
PersistentKeepalive = 25
```

---



