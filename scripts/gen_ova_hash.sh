#!/bin/bash

# Script pour générer automatiquement les hash SHA256 des fichiers OVA et créer un tag Git

# Vérifier si les outils nécessaires sont installés
command -v sha256sum >/dev/null 2>&1 || { echo "sha256sum est requis mais n'est pas installé. Aborting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo "git est requis mais n'est pas installé. Aborting."; exit 1; }

# Chemin vers le répertoire OVA
OVA_DIR="../ova"

# Vérifier si le répertoire OVA existe
if [ ! -d "$OVA_DIR" ]; then
    echo "Le répertoire $OVA_DIR n'existe pas."
    exit 1
fi

# Fonction pour générer le hash d'un fichier OVA
generate_hash() {
    local ova_file="$1"
    local hash_file="${ova_file%.*}.hash"
    
    echo "Génération du hash pour $ova_file..."
    sha256sum "$ova_file" > "$hash_file"
    
    # Formater le fichier hash pour qu'il soit compatible avec sha256sum -c
    sed -i "s|  |  *|" "$hash_file"
    
    echo "Hash enregistré dans $hash_file"
    
    # Afficher le hash généré
    cat "$hash_file"
}

# Fonction pour créer un tag Git
create_git_tag() {
    local ova_file="$1"
    local hash_file="${ova_file%.*}.hash"
    local ova_name=$(basename "$ova_file" .ova)
    local hash=$(cut -d ' ' -f 1 "$hash_file")
    local tag_name="ova-${ova_name}-${hash:0:8}"
    local tag_message="OVA: ${ova_name} avec hash SHA256: ${hash}"
    
    echo "Création du tag Git $tag_name..."
    git tag -a "$tag_name" -m "$tag_message"
    
    echo "Tag Git créé. Pour pousser le tag vers le dépôt distant, exécutez:"
    echo "git push origin $tag_name"
}

# Traiter tous les fichiers OVA dans le répertoire
find "$OVA_DIR" -name "*.ova" | while read ova_file; do
    generate_hash "$ova_file"
    create_git_tag "$ova_file"
    echo "-----------------------------------"
done

echo "Terminé!"
exit 0 