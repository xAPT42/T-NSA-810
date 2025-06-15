# Fichiers OVA

Ce répertoire contient les images OVA des machines virtuelles utilisées dans le projet.

## Structure

- `machine-1.ova` : Image OVA de la machine 1
- `machine-1.hash` : Fichier contenant le hash SHA256 de l'image OVA

## Génération des hash

Les hash SHA256 sont générés automatiquement avec le script `../scripts/gen_ova_hash.sh`.

## Utilisation

Pour importer une machine virtuelle :

1. Vérifiez l'intégrité de l'image OVA avec la commande :
   ```
   sha256sum -c machine-1.hash
   ```

2. Importez l'image dans votre hyperviseur (VirtualBox, VMware, Proxmox) :
   - Pour VirtualBox : `VBoxManage import machine-1.ova`
   - Pour VMware : Utilisez l'interface graphique "Import OVA"
   - Pour Proxmox : Utilisez l'interface web pour importer l'OVA 