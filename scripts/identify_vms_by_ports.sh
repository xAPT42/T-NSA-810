#!/bin/bash

# ==============================================================================
# identify_vms_by_ports.sh
# 
# Description: Script pour identifier les VMs en fonction des ports ouverts
#              dans un environnement VirtualBox avec réseau en mode ponté
#              ou en partage de connexion (tethering).
#
# Utilisation: ./identify_vms_by_ports.sh
#
# Contexte: Projet T-NSA-810
# ==============================================================================

# Vérification des privilèges sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Ce script nécessite des privilèges root pour fonctionner correctement."
    echo "[*] Redémarrage du script avec sudo..."
    exec sudo "$0" "$@"
    exit
fi

# Configuration
SUBNET="172.20.10.0/28"
PORTS="22,80,443,3306,8000,9000,3000"  # SSH, HTTP, HTTPS, MySQL, Nagios, Portainer, Gitea

# Message de début
echo "====================================================="
echo "    Identification des VMs par services (ports)"
echo "====================================================="
echo "[*] Scan réseau en cours sur $SUBNET..."
echo "[*] Ports scannés: $PORTS (SSH, HTTP, HTTPS, MySQL, Nagios, Portainer, Gitea)"
echo ""

# Création d'un fichier temporaire pour stocker les résultats
TEMP_FILE=$(mktemp)

# Exécution du scan avec plus de verbosité
echo "[*] Lancement du scan nmap avec privilèges root..."
sudo nmap -p $PORTS -sV $SUBNET -v -oG $TEMP_FILE

# Vérification si des hôtes sont trouvés
if grep -q "Status: Up" $TEMP_FILE; then
    echo ""
    echo "[*] Résultats du scan:"
    echo "-----------------------------------------------------"
    
    # Traitement des résultats
    cat $TEMP_FILE | awk '
    /Host: / {ip=$2; host_found=1}
    /22\/open/ {ssh=1}
    /80\/open/ {http=1}
    /443\/open/ {https=1}
    /3306\/open/ {mysql=1}
    /8000\/open/ {nagios=1}
    /9000\/open/ {portainer=1}
    /3000\/open/ {gitea=1}
    /Status: Up/ && host_found==1 {
        # Attribution des rôles en fonction des services détectés
        if (portainer == 1)             print "VM_Portainer  = " ip
        else if (mysql == 1)            print "VM_DB         = " ip
        else if (gitea == 1)            print "VM_Gitea      = " ip
        else if (nagios == 1)           print "VM_Nagios     = " ip
        else if (http == 1 && ssh == 1) print "VM_Web        = " ip
        else if (ssh == 1)              print "VM_SSH        = " ip
        else                            print "VM_Inconnue   = " ip " (services non identifiés)"
        
        # Réinitialisation des variables pour la prochaine IP
        host_found=0; ip=""; ssh=0; http=0; https=0; mysql=0; nagios=0; portainer=0; gitea=0
    }'
else
    echo ""
    echo "[!] Aucun hôte actif trouvé sur le réseau $SUBNET"
    echo "[!] Vérifiez votre connexion réseau ou la plage d'adresses IP"
    
    # Afficher les informations de débogage
    echo ""
    echo "[*] Informations de débogage:"
    echo "-----------------------------------------------------"
    echo "Interface réseau:"
    ip addr | grep -E "inet "
fi

# Nettoyage
rm -f $TEMP_FILE

echo ""
echo "====================================================="
echo "[*] Scan terminé!"
echo "====================================================="
