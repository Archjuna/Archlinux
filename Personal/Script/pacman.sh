#!/bin/sh
#Mise à jour journalière de la base de donnée et du cache de pacman
if [ -x /usr/bin/pacman ]; then
#Mise à jour des mirroirs
  	/home/archjuna/Script/Maj_mirror.sh
#Téléchargement des mise à jour
    /usr/bin/pacman -Syuw --noprogressbar --noconfirm
   	echo "echo Mise à jour prête !" > /home/archjuna/Script/MAJ.sh && chmod +x /home/archjuna/Script/MAJ.sh
fi

