# 🔍 Scan de la Machine Web (192.168.145.140)

## Scan Nmap Détaillé
```bash
nmap -sV --script vuln -p- -oN vuln_140.txt 192.168.145.140
```

### Résultats du Scan
Date du scan : [à compléter]

#### Services Détectés
| Port    | État  | Service | Version            |
|---------|-------|---------|-------------------|
| 21/tcp  | open  | ftp     | [version]          |
| 22/tcp  | open  | ssh     | [version]          |
| 80/tcp  | open  | http    | [version]          |
| 8080/tcp| open  | http-alt| [version]          |

#### Vulnérabilités Critiques Détectées
- [À compléter après scan]

### Analyse Préliminaire
- [À compléter]

### Recommandations Immédiates
- [À compléter]

## Vulnérabilités Critiques

1. **CVE-2015-3306**
   - Score CVSS : 10.0
   - Description : Vulnérabilité critique dans ProFTPD permettant l'exécution de code à distance.
   - Lien : [CVE-2015-3306](https://vulners.com/cve/CVE-2015-3306)

2. **CVE-2023-38408**
   - Score CVSS : 9.8
   - Description : Vulnérabilité critique dans OpenSSH 7.4 permettant l'exécution de code à distance.
   - Lien : [CVE-2023-38408](https://vulners.com/cve/CVE-2023-38408)

3. **CVE-2020-15778**
   - Score CVSS : 7.8
   - Description : Vulnérabilité dans OpenSSH permettant l'accès non autorisé.
   - Lien : [CVE-2020-15778](https://vulners.com/cve/CVE-2020-15778)

4. **CVE-2022-41741**
   - Score CVSS : 7.8
   - Description : Vulnérabilité dans nginx 1.16.1 permettant des attaques par déni de service.
   - Lien : [CVE-2022-41741](https://vulners.com/cve/CVE-2022-41741)

5. **CVE-2007-6750**
   - Score CVSS : 7.5
   - Description : Vulnérabilité Slowloris DOS attack sur le serveur web.
   - Lien : [CVE-2007-6750](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750) 