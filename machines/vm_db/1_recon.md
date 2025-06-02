# 🔍 Scan de la Machine Base de Données (192.168.145.144)

## Scan Nmap Détaillé
```bash
nmap -sV --script vuln -p- -oN vuln_144.txt 192.168.145.144
```

### Résultats du Scan
Date du scan : [à compléter]

#### Services Détectés
| Port    | État  | Service | Version            |
|---------|-------|---------|-------------------|
| 22/tcp  | open  | ssh     | [version]          |
| 80/tcp  | open  | http    | [version]          |
| 3306/tcp| open  | mysql   | [version]          |

#### Vulnérabilités Critiques Détectées
- [À compléter après scan]

### Analyse Préliminaire
- [À compléter]

### Recommandations Immédiates
- [À compléter]

## Vulnérabilités Critiques

1. **CVE-2023-38408**
   - Score CVSS : 9.8
   - Description : Vulnérabilité critique dans OpenSSH 7.4 permettant l'exécution de code à distance.
   - Lien : [CVE-2023-38408](https://vulners.com/cve/CVE-2023-38408)

2. **CVE-2020-15778**
   - Score CVSS : 7.8
   - Description : Vulnérabilité dans OpenSSH permettant l'accès non autorisé.
   - Lien : [CVE-2020-15778](https://vulners.com/cve/CVE-2020-15778)

3. **CVE-2007-6750**
   - Score CVSS : 7.5
   - Description : Vulnérabilité Slowloris DOS attack sur le serveur web.
   - Lien : [CVE-2007-6750](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750)

4. **CVE-2022-31813**
   - Score CVSS : 9.8
   - Description : Vulnérabilité critique dans le serveur HTTP Apache.
   - Lien : [CVE-2022-31813](https://vulners.com/cve/CVE-2022-31813)

5. **CVE-2021-44790**
   - Score CVSS : 9.8
   - Description : Vulnérabilité critique dans le serveur HTTP Apache.
   - Lien : [CVE-2021-44790](https://vulners.com/cve/CVE-2021-44790) 