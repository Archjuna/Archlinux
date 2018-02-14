#!/bin/bash
#* ************************************************************************** *#
#* ************************************************    ********************** *#
#* **  by: Archjuna  *****************************  **  ********************* *#
#* **********************************************  ****  ******************** *#
#* **  mail: archjuna@net-c.com  ***************  ******  ******************* *#
#* ******************************************    ********    **************** *#
#* *****************************************    **********    *************** *#
#* ******************************************  ************  **************** *#
#* *****************************************  **************  *************** *#
#* ****************************************  ****************  ************** *#
#* ************************************************************************** *#
if [ $EUID != 0 ]; then
  echo "erreur : vous ne pouvez pas effectuer cette opération à moins d’être root."; exit 1; fi
# Script de nettoyage du system.
notify-send 'Nettoyage du systeme' 'État ==> Démarré'
# Supprime le cache de pacman.
paccache -r
# Supprime les paquets non installés.
paccache -ruk0
# Supprime les paquets orphelins.
echo o | yaourt -Qdt
# Mise à jour des mirroirs.
/home/archjuna/Script/Maj_mirror.sh
# Synchronise pacman.
pacman -Syy
# nettoyage des vignettes
rm -rf ~/.thumbnails/normal/*
# Mise à jour du system si aucune News
echo -e "\\e[01;31m\t\t >> News Archlinux.fr << \\e[00m\n$(curl -s https://archlinux.fr/feed | sed '/<title\|<pubDate/!d;s/\t*//g;s/<\/*title>/ - /g;s/[0-9]*:.*/\\e[00m/g;s/&#8217;/'"'"'/g;s/&#8211;/-/g;/Archlinux.fr/d' | sed 'N;s/\n<pubDate>/\\033[1;34m/g;P;D;')" > /home/archjuna/Script/save_new/new
sleep 2
if diff /home/archjuna/Script/save_new/old /home/archjuna/Script/save_new/new;then
	pacman -Syu --noconfirm
	yaourt -Syua --noconfirm
	notify-send 'Nettoyage du system' 'Mise à jour complete du systeme !'
else
	notify-send 'Nettoyage du system' 'Des nouvelles sont apparues sur Archlinux.org'
fi
	notify-send 'Nettoyage du system' 'État Terminé'
