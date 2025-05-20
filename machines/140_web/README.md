# 🌐 Machine Web (192.168.145.140)

## Description Générale
Serveur Web principal de l'infrastructure T-NSA-810. Héberge des services web et FTP.

## 📊 Informations de Base
- **IP :** 192.168.145.140
- **Rôle :** Serveur Web principal
- **Services principaux :**
  - FTP (21/tcp)
  - SSH (22/tcp)
  - HTTP (80)
  - HTTP-alt (8080)

## 📁 Structure de Documentation
```
140_web/
├── README.md     # Ce fichier
├── scan.md       # Résultats détaillés des scans
├── exploit.md    # Détails des exploitations
└── rapport.md    # Rapport final et recommandations
```

## 🎯 Points d'Attention
1. Multiples services exposés (FTP, HTTP, SSH)
2. Risque de failles web (injection, XSS, etc.)
3. FTP souvent mal sécurisé

## 📝 Notes
- Tester les accès par défaut sur FTP et HTTP
- Vérifier la configuration des répertoires web
- Analyser les vulnérabilités sur chaque service 