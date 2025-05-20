# 🛢️ Machine Base de Données (192.168.145.144)

## Description Générale
Serveur de base de données de l'infrastructure T-NSA-810. Héberge un service MySQL et d'autres services d'administration.

## 📊 Informations de Base
- **IP :** 192.168.145.144
- **Rôle :** Serveur base de données
- **Services principaux :**
  - SSH (22/tcp)
  - HTTP (80)
  - MySQL (3306)

## 📁 Structure de Documentation
```
144_db/
├── README.md     # Ce fichier
├── scan.md       # Résultats détaillés des scans
├── exploit.md    # Détails des exploitations
└── rapport.md    # Rapport final et recommandations
```

## 🎯 Points d'Attention
1. MySQL exposé sur le réseau
2. Risque d'injection SQL
3. Accès SSH root possible

## 📝 Notes
- Tester les accès par défaut MySQL
- Vérifier la configuration des bases
- Analyser les vulnérabilités SSH et HTTP 