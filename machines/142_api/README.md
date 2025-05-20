# 🔐 Machine API (192.168.145.142)

## Description Générale
Serveur API faisant partie de l'infrastructure T-NSA-810. Cette machine héberge principalement un service SSH et potentiellement d'autres services d'API.

## 📊 Informations de Base
- **IP :** 192.168.145.142
- **Rôle :** Serveur API / Auth
- **Services principaux :**
  - SSH (22/tcp)
  - HTTP (80)
  - Port custom (222)

## 📁 Structure de Documentation
```
142_api/
├── README.md     # Ce fichier
├── scan.md       # Résultats détaillés des scans
├── exploit.md    # Détails des exploitations
└── rapport.md    # Rapport final et recommandations
```

## 🎯 Points d'Attention
1. OpenSSH 7.4 avec vulnérabilités critiques
2. Plusieurs ports exposés
3. Configuration par défaut potentiellement non sécurisée

## 📝 Notes
- Accès SSH possible avec identifiants root/admin
- Plusieurs CVE critiques identifiées
- Nécessite une mise à jour urgente d'OpenSSH 