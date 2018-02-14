#!/bin/sh
#Pour l'affichage de la TODO liste dans le conky et des MAJ
if [ -f ~/Script/MAJ.sh ]; then
       	~/Script/MAJ.sh
fi
if [ -f ~/Script/todo ]; then
		echo -e
		~/Script/todo
fi