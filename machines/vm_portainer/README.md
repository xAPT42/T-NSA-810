# 📊 Machine Portainer (192.168.145.143)

## Description Générale
Serveur de gestion de conteneurs Portainer dans l'infrastructure T-NSA-810.

## 📊 Informations de Base
- **IP :** 192.168.145.143
- **Rôle :** Monitoring / Portainer
- **Services principaux :**
  - SSH (22/tcp)
  - HTTP-alt (8000)
  - Portainer (9000)

## 📁 Structure de Documentation
```
143_portainer/
├── README.md     # Ce fichier
├── scan.md       # Résultats détaillés des scans
├── exploit.md    # Détails des exploitations
└── rapport.md    # Rapport final et recommandations
```

## 🎯 Points d'Attention
1. Interface Portainer exposée
2. Risque d'accès non authentifié
3. Possibilité de compromission de conteneurs

## 📝 Notes
- Tester l'accès à l'interface web Portainer
- Vérifier la configuration des conteneurs
- Analyser les vulnérabilités SSH et HTTP-alt 