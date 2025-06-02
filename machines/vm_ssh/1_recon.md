# 🔍 Scan de la Machine API (192.168.145.142)

## Scan Nmap Détaillé
```bash
nmap -sV --script vuln -p- -oN vuln_142.txt 192.168.145.142
```

### Résultats du Scan
Date du scan : 2025-05-20 02:40 CEST

#### Services Détectés
| Port    | État  | Service | Version            |
|---------|-------|---------|-------------------|
| 22/tcp  | open  | ssh     | OpenSSH 7.4 (protocol 2.0) |

#### Vulnérabilités Critiques Détectées

1. **CVE-2023-38408** (Score: 9.8)
   - Service: OpenSSH
   - Détails: [https://vulners.com/cve/CVE-2023-38408](https://vulners.com/cve/CVE-2023-38408)

2. **CVE-2020-15778** (Score: 7.8)
   - Service: OpenSSH
   - Détails: [https://vulners.com/cve/CVE-2020-15778](https://vulners.com/cve/CVE-2020-15778)

3. **CVE-2021-41617** (Score: 7.0)
   - Service: OpenSSH
   - Détails: [https://vulners.com/cve/CVE-2021-41617](https://vulners.com/cve/CVE-2021-41617)

#### Autres Vulnérabilités Notables
- PACKETSTORM:173661 (Score: 7.5)
- PACKETSTORM:189283 (Score: 6.8)
- CVE-2025-26465 (Score: 6.8)
- CVE-2019-6110 (Score: 6.8)

### Analyse Préliminaire
1. Le serveur SSH présente plusieurs vulnérabilités critiques
2. La version d'OpenSSH (7.4) est obsolète
3. Plusieurs exploits publics sont disponibles

### Recommandations Immédiates
1. Mettre à jour OpenSSH vers la dernière version stable
2. Restreindre l'accès SSH par IP
3. Implémenter une authentification par clé plutôt que par mot de passe 

## Vulnérabilités Critiques

1. **CVE-2023-38408**
   - Score CVSS : 9.8
   - Description : Vulnérabilité critique dans OpenSSH 7.4 permettant l'exécution de code à distance.
   - Lien : [CVE-2023-38408](https://vulners.com/cve/CVE-2023-38408)

2. **CVE-2020-15778**
   - Score CVSS : 7.8
   - Description : Vulnérabilité dans OpenSSH permettant l'accès non autorisé.
   - Lien : [CVE-2020-15778](https://vulners.com/cve/CVE-2020-15778)

3. **CVE-2021-41617**
   - Score CVSS : 7.0
   - Description : Vulnérabilité dans OpenSSH permettant des attaques par déni de service.
   - Lien : [CVE-2021-41617](https://vulners.com/cve/CVE-2021-41617)

4. **CVE-2007-6750**
   - Score CVSS : 7.5
   - Description : Vulnérabilité Slowloris DOS attack sur le serveur web.
   - Lien : [CVE-2007-6750](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750)

5. **CVE-2011-3192**
   - Score CVSS : 7.5
   - Description : Vulnérabilité Apache byterange filter DoS.
   - Lien : [CVE-2011-3192](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-3192) 