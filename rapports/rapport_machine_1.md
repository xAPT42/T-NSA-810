# Rapport de sécurité - Machine 1

## Informations générales

- **Nom de la machine** : vm_web
- **Date de l'audit** : 15/11/2023
- **Auditeur** : Équipe NSA-810

## Résumé exécutif

Cette machine virtuelle héberge un serveur web NGINX avec plusieurs vulnérabilités identifiées. L'audit de sécurité a révélé des problèmes critiques qui nécessitent une attention immédiate.

## Vulnérabilités identifiées

### Critiques

1. **CVE-2023-XXXX** - Nginx version 1.18.0 vulnérable à une injection de code
   - **Impact** : Exécution de code à distance
   - **CVSS** : 9.8
   - **Recommandation** : Mettre à jour vers la version 1.20.1 ou supérieure

2. **Mots de passe faibles**
   - **Impact** : Accès non autorisé aux comptes système
   - **CVSS** : 8.5
   - **Recommandation** : Implémenter une politique de mots de passe forts

### Importantes

3. **Services non nécessaires actifs**
   - **Impact** : Surface d'attaque élargie
   - **CVSS** : 6.5
   - **Recommandation** : Désactiver les services non essentiels (telnet, ftp)

4. **Permissions incorrectes sur les fichiers de configuration**
   - **Impact** : Divulgation d'informations sensibles
   - **CVSS** : 6.2
   - **Recommandation** : Appliquer des permissions restrictives (600) sur les fichiers de configuration

### Modérées

5. **Absence de pare-feu**
   - **Impact** : Exposition inutile des services
   - **CVSS** : 5.0
   - **Recommandation** : Configurer UFW pour limiter l'accès aux ports nécessaires

## Plan de remédiation

| Vulnérabilité | Action | Priorité | Responsable | Délai |
|---------------|--------|----------|-------------|-------|
| CVE-2023-XXXX | Mettre à jour Nginx | Critique | Admin Système | 24h |
| Mots de passe faibles | Changer les mots de passe | Critique | Admin Système | 24h |
| Services non nécessaires | Désactiver telnet, ftp | Haute | Admin Système | 48h |
| Permissions incorrectes | Corriger les permissions | Haute | Admin Système | 48h |
| Absence de pare-feu | Configurer UFW | Moyenne | Admin Réseau | 72h |

## Tests effectués

- Scan de vulnérabilités avec Nessus
- Analyse des permissions avec Lynis
- Test de pénétration avec OWASP ZAP
- Audit de configuration avec OpenSCAP

## Conclusion

La machine présente plusieurs vulnérabilités qui doivent être corrigées rapidement pour éviter toute compromission. L'application du playbook Ansible `fix-vuln.yml` permettra de résoudre la majorité des problèmes identifiés. 