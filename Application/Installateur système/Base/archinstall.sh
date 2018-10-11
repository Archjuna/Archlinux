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

# Script d'installation et de configuration assez avancé d'Archlinux
# Ce script n'installera que le nécessaire au démarrage d'Archlinux mais,
# si l'utilisateur le souhaite il ira jusque installer une Archlinux avec XFCE4 
# et sécurisée.
# Un seconds script pourra être lancé pour le paramètrage de XFCE4.
# Un Wiki est disponible pour plus d'explication.

Reste à faire :
log et gestion des bug ou erreurs.
ajout du second script au Redemarrage.
La deuxieme partie.
le nettoyage.



#------------------------------------------------------------------------------#
#									Variables								   #
#------------------------------------------------------------------------------#

PROCESSEUR=Intel
CG=AMD
read -r "Est-ce une Installation sur VB ? o/n" answer
	case $answer in
		"o|O") CG=VB;;
		*) lspci | grep -e VGA -e 3D | grep -i AMD || CG=NVIDIA;;
	esac

lscpu | grep -i intel || PROCESSEUR=AMD

#------------------------------------------------------------------------------#

loadkeys fr
#------------------------------------------------------------------------------#
#									partitionement                             #
#------------------------------------------------------------------------------#

read -p "voulez-vous utiliser le swap ? non par defaut" answer
case "$answer" in
	"o|O") SWAP=OUI;;
	*) SWAP=NON;;
esac

echo "Veuillez effectuer ces commandes, afin de partitionner votre disque; \nLancer l'utilitaire cgdisk et supprimer toutes les partitions \n Ensuite : \n New => 512M => EF00 \n Si vous souhaiter utiliser le swapp : New => Taille de la RAM => 8200 \n Sinon New => 20 ou 25G => 8300 \n New => Reste => 8302 \n Write et Quit. \n Voila les partitions sont créées."

read -p "Comment voulez-vous être connecté à internet ?\n 1- Fillaire.\n2- Wifi" answerw
if $answerw = "2"; then
	wifi-menu
fi
timedatectl set-ntp true

read -p "Veuillez entrer le chemin complet de votre disk :\nExemple : /dev/sda" answer
	DISK=$answer


#------------------------------------------------------------------------------#
#									Formatage                                  #
#------------------------------------------------------------------------------#

mkfs.vfat -F32 $DISK\1

if $SWAPP = "OUI";then
	mkswap $DISK\2
	swapon $DISK\2
	mkfs.ext4 $DISK\3 && mkfs.ext4 $DISK\4
else
	mkfs.ext4 $DISK\2 && mkfs.ext4 $DISK\3
fi

#------------------------------------------------------------------------------#
#									Montage                                    #
#------------------------------------------------------------------------------#
if $SWAPP = "OUI";then
	mount $DISK\3 /mnt && mkdir -p /mnt/{home,boot/efi} && mount $DISK\4 /mnt/home && mount -t vfat $DISK\1 /mnt/boot/efi
else
	mount $DISK\2 /mnt && mkdir -p /mnt/{home,boot/efi} && mount $DISK\3 /mnt/home && mount -t vfat $DISK\1 /mnt/boot/efi
fi
	
#------------------------------------------------------------------------------#
#									Serveur                                    #
#------------------------------------------------------------------------------#

wget https://raw.githubusercontent.com/Archjuna/Archlinux/master/Personal/Script/Maj_mirror.sh -O mirroir.sh && chmod +x mirroir.sh && ./mirroir.sh

#------------------------------------------------------------------------------#
#									Installation                               #
#------------------------------------------------------------------------------#

pacstrap /mnt base base-devel
pacstrap /mnt zip unzip p7zip vim mc alsa-utils syslog-ng mtools dosfstools lsb-
release ntfs-3g exfat-utils grub os-prober efibootmgr ntp cronie git networkmanager gnome-keyring network-manager-applet 

if $answerw = "2";then
	pacstrap /mnt iw wpa_supplicant
fi

if $PROCESSEUR = "Intel";then
	pacstrap /mnt intel-ucode
else
	pacstrap /mnt amd-ucode
fi
#------------------------------------------------------------------------------#
#									Configuration							   #
#------------------------------------------------------------------------------#
genfstab -U -p /mnt >> /mnt/etc/fstab
ask 'Comment voulez-vous appeler cet ordinateur ?'
arch-chroot /mnt echo $answer > /etc/hostname
arch-chroot /mnt echo '127.0.1.1 $answer.localdomain $answer' >> /etc/hosts
arch-chroot /mnt ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
arch-chroot /mnt sed -i -e 's/#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/g' /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt echo LANG="fr_FR.UTF-8" > /etc/locale.conf
arch-chroot /mnt export LANG=fr_FR.UTF-8
arch-chroot /mnt echo KEYMAP=fr > /etc/vconsole.conf
arch-chroot /mnt hwclock --systohc --utc
arch-chroot /mnt mkinitcpio -p linux

#------------------------------------------------------------------------------#
#									Bootloader								   #
#------------------------------------------------------------------------------#

arch-chroot /mnt mkdir -p /boot/efi/EFI
arch-chroot /mnt mount -t efivarfs efivarfs /sys/firmware/efi/efivars
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

#------------------------------------------------------------------------------#
#									Utilisateur								   #
#------------------------------------------------------------------------------#
arch-chroot /mnt echo "Veuillez entrer le mot de pass ROOT !"
arch-chroot /mnt passwd root
arch-chroot /mnt read -p "Veuillez indiquez un nom d'utilisateur" answer
arch-chroot /mnt useradd -m -g wheel -c $answer -s /bin/bash $answer
arch-chroot /mnt echo "Entrer un mot de passe !"
passwd $answer

#------------------------------------------------------------------------------#
#									Redemarrage								   #
#------------------------------------------------------------------------------#

arch-chroot /mnt sytemctl enable networkmanager
umount -R /mnt
reboot
