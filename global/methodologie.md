# 📋 Méthodologie d'Audit

## 1. Reconnaissance
1. **Scan réseau initial**
   ```bash
   sudo nmap -sn 192.168.145.0/24
   ```
   - Identification des machines actives
   - Cartographie du réseau

2. **Scan des services**
   ```bash
   sudo nmap -sS -sV -p- -A -oN scan_complet.txt <ip>
   ```
   - Détection des services
   - Identification des versions

## 2. Énumération
1. **Scan de vulnérabilités**
   ```bash
   nmap -sV --script vuln -p- -oN vuln_<ip>.txt <ip>
   ```
   - Recherche de CVE
   - Évaluation des risques

2. **Bruteforce des identifiants**
   - Utilisation de John the Ripper
   - Test des combinaisons user/password

## 3. Exploitation
1. **Analyse des vulnérabilités**
   - Priorisation par score CVSS
   - Recherche d'exploits

2. **Tests d'intrusion**
   - Exploitation des failles
   - Élévation de privilèges

## 4. Documentation
1. **Par machine**
   - Résultats des scans
   - Vulnérabilités exploitées
   - Recommandations spécifiques

2. **Globale**
   - Synthèse des risques
   - Recommandations générales
   - Plan d'action 