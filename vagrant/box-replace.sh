#!/bin/bash

# Script pour remplacer une box Vagrant par une autre

# Vérifier les arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <nom_box_actuelle> <nom_nouvelle_box>"
    echo "Exemple: $0 ubuntu/focal64 ubuntu/jammy64"
    exit 1
fi

CURRENT_BOX=$1
NEW_BOX=$2

# Vérifier si Vagrant est installé
if ! command -v vagrant &> /dev/null; then
    echo "Vagrant n'est pas installé. Veuillez l'installer avant d'exécuter ce script."
    exit 1
fi

# Vérifier si le Vagrantfile existe
if [ ! -f "Vagrantfile" ]; then
    echo "Vagrantfile non trouvé dans le répertoire courant."
    exit 1
fi

echo "Remplacement de la box '$CURRENT_BOX' par '$NEW_BOX' dans le Vagrantfile..."

# Remplacer la box dans le Vagrantfile
sed -i "s|config.vm.box = \"$CURRENT_BOX\"|config.vm.box = \"$NEW_BOX\"|g" Vagrantfile

# Vérifier si la substitution a été effectuée
if grep -q "config.vm.box = \"$NEW_BOX\"" Vagrantfile; then
    echo "Box remplacée avec succès dans le Vagrantfile."
else
    echo "Erreur: La box n'a pas pu être remplacée."
    exit 1
fi

echo "Mise à jour des machines virtuelles..."

# Détruire les machines existantes
vagrant destroy -f

# Télécharger la nouvelle box si nécessaire
vagrant box add $NEW_BOX --provider virtualbox

# Recréer les machines avec la nouvelle box
vagrant up

echo "Remplacement terminé avec succès!" 