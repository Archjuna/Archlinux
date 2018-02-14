#!/usr/bin/bash
# Download pacman ranked mirrorlist
# This script is a simplification of https://raw.githubusercontent.com/Gen2ly/armrr/master/armrr
# For more information please visit https://github.com/Gen2ly/armrr

country="FR"

# Root user access test
if [ $EUID != 0 ]; then
  echo "erreur : vous ne pouvez pas effectuer cette opération à moins d’être root."; exit 1; fi

# Download
url="https://www.archlinux.org/mirrorlist/?country=${country}&protocol=http&ip_version=4&use_mirror_status=on"
tmp_ml=$(mktemp --suffix=-mirrorlist)  # temporary mirrorlist
if curl -s "$url" -o "$tmp_ml"; then
  if ! grep "^## Arch Linux repository mirrorlist" "$tmp_ml" > /dev/null; then
    echo "erreur : téléchargement invalide"
    exit 1
  fi
else
  echo "erreur : le téléchargement à échoué"
  exit 1
fi

# Edit
sed -i 's/^#Server/Server/g' "$tmp_ml"

if [ -f /etc/pacman.d/mirrorlist ]; then
  mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist_backup_$(date +%Y%m%d%H%M)
  install -Dm644 "$tmp_ml" /etc/pacman.d/mirrorlist
else
  echo "Attention: aucun fichier /etc/pacman.d/mirrorlist"
fi
