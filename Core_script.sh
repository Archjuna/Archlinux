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

#******************************  Variables  ***********************************#

ide=intellij-idea-ultimate-edition
navigateur=vivaldi
discord=discord-canary
tweeter=corebird

#******************************************************************************#
#**********************  Fonction de verification  ****************************#

ft_checkInstall()
{
	if pacman -Qi $1 &> /dev/null;then
		echo -e "\033[32mOK\033[0m "$1" est bien installé !\n"
	else
		if [ $2 = test2 ];then
			echo -e "\033[31;7mAttention :\033[0m Des erreurs ont été rencontrée.\n"
			echo "Veuillez corriger les erreurs avant de continuer"
			exit 105
		fi
	fi
}

#******************************************************************************#
#**********************  Fonction d'installation  *****************************#

ft_install()
{
#Verification de la presence du paquet

	package=$1
	ft_checkInstall $package test1

#installation du paquet avec packer

	if pacman -Qi packer &> /dev/null; then
		packer -S --noconfirm --noedit  $package
	fi
	ft_checkInstall $package test2
}

ft_dependency()
{
for package in cmake clang discord-canary
do
	ft_install $package
done
}

#******************************************************************************#

echo    "################################################################"
echo    "###################    Bienvenu sous Archlinux  ################"
echo -e "################################################################\n"

echo "Ce script à pour but d'installer les outils nécessaire à la personalisation de Archlinux"
echo -e "Pour ce faire il installera avant des composants, puis les packs de thème et enfin vous demandera pour les installation facultative.\n"
echo    "################################################################"
echo    "##################  Debut de l'installation  ###################"
echo    "#####################       Partie 1       #####################"
echo -e "################################################################\n"

#Installation des composants

sudo pacman -S --noconfirm --needed archey3 baobab bleachbit catfish conky curl 2> erreur.log
sudo pacman -S --noconfirm --needed dconf-editor 2>> erreur.log
sudo pacman -S --noconfirm --needed dmidecode 2>> erreur.log
sudo pacman -S --noconfirm --needed filezilla 2>> erreur.log
sudo pacman -S --noconfirm --needed gksu glances 2>> erreur.log
sudo pacman -S --noconfirm --needed gnome-font-viewer gnome-screenshot gnome-system-monitor gnome-terminal gnome-tweak-tool 2>> erreur.log
sudo pacman -S --noconfirm --needed gparted 2>> erreur.log
sudo pacman -S --noconfirm --needed hardinfo hddtemp hexchat htop 2>> erreur.log
sudo pacman -S --noconfirm --needed inxi lm_sensors meld mlocate mpv 2>> erreur.log
sudo pacman -S --noconfirm --needed net-tools notify-osd numlockx plank 2>> erreur.log
sudo pacman -S --noconfirm --needed redshift ristretto screenfetch shotwell 2>> erreur.log
sudo pacman -S --noconfirm --needed simplescreenrecorder sysstat 2>> erreur.log
sudo pacman -S --noconfirm --needed thunar tumbler 2>> erreur.log
sudo pacman -S --noconfirm --needed vlc vnstat wget unclutter 2>> erreur.log
ft_checkError erreur.log

#Gestion des erreurs

ft_checkError()
{
	if grep erreur $1;then
		echo -e "\033[31;7mAttention :\033[0m Des erreurs ont été rencontrée.\n"
		echo "Veuillez corriger les erreurs avant de continuer"
		rm $1
		exit 100
	else
		echo -e "\033[32mOK\033[0m L'installation c'est bien déroulée.\n"
	fi
}

#Installation des gestionnaire d'archive (si le script d'installation n'a pas été utilisé)

sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller

#Activation de vnstat

sudo systemctl enable vnstat
sudo systemctl start vnstat

#Nettoyage du fichier d'erreur

rm erreur.log

echo    "################################################################"
echo    "#####################       Partie 2       #####################"
echo -e "################################################################\n"
echo "Dans cette section le script installera Packer (pour les paquets AUR) "

#Verification si packer est bien installé

ft_checkInstallPacker()
{
	if pacman -Qi $1 &> /dev/null;then
		echo -e "\033[32mOK\033[0m Packer est bien installé !\n"
	else
		if [ $2 = "test2" ];then
			echo -e "\033[31;7mAttention :\033[0m Des erreurs ont été rencontrée.\n"
			echo "Veuillez corriger les erreurs avant de continuer"
			exit 101
		else
			sudo pacman -S --noconfirm --needed grep sed bash curl pacman jshon expac
			[ -d /tmp/packer ] && rm -rf /tmp/packer
			mkdir /tmp/packer
			wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
			mv PKGBUILD\?h\=packer /tmp/packer/PKGBUILD
			cd /tmp/packer
			makepkg -i /tmp/packer --noconfirm
			[ -d /tmp/packer ] && rm -rf /tmp/packer
		fi
	fi
}

#Installation de packer

for packertest in test1 test2
do
	ft_checkInstallPacker packer $packertest
done


echo    "################################################################"
echo    "#####################       Partie 3       #####################"
echo -e "################################################################\n"
echo "Dans cette section le script installera les outils extra et les thèmes."

#Installation des outils extra

for package in neofetch sublime-text-dev mugshot
do
	ft_checkInstall $package
done

#Installation des outils nécessaires

sudo pacman -S --needed --noconfirm xdg-user-dirs 2> erreur2.log


#Installation des Fonts

sudo pacman -S noto-fonts --noconfirm --needed
sudo pacman -S xfce4-whiskermenu-plugin --noconfirm --needed

#Gestion des erreurs

ft_checkError erreur2.log

#Installation de hardcode-fixer

[ -d /tmp/hardcode-fixer ] && rm -rf "/tmp/hardcode-fixer" || echo ""

#Clonnage du git et lancement su script

git clone https://github.com/Foggalong/hardcode-fixer /tmp/hardcode-fixer
sudo /tmp/hardcode-fixer/fix.sh

#Nettoyage

ft_clean()
{
rm -rf /tmp/hardcode-fixer
[ -d /tmp/Sardi-Extra ] && rm -rf /tmp/Sardi-Extra
[ -d /tmp/sardi ] && rm -rf /tmp/sardi
[ -d /tmp/Surfn ] && rm -rf /tmp/Surfn
rm -rf /tmp/Plank-Themes
}

#Installation des thèmes

ft_clean
[ -d $HOME"/.icons" ] || mkdir -p $HOME"/.icons"

#Plank

git clone https://github.com/erikdubois/Plank-Themes /tmp/Plank-Themes
find /tmp/Plank-Themes -maxdepth 1 -type f -exec rm -rf '{}' \;
[ -d $HOME"/.local/share/plank" ] || mkdir -p $HOME"/.local/share/plank"
[ -d $HOME"/.local/share/plank/themes" ] || mkdir -p $HOME"/.local/share/plank/themes"
cp -r /tmp/Plank-Themes/* ~/.local/share/plank/themes/
ft_clean

#Surfn

git clone https://github.com/erikdubois/Surfn /tmp/Surfn
find /tmp/Surfn -maxdepth 1 -type f -exec rm -rf '{}' \;
cp -rf /tmp/Surfn/* ~/.icons/
ft_clean

#Sardi

wget -O /tmp/sardi.tar.gz "https://sourceforge.net/projects/sardi/files/latest/download?source=files"
mkdir /tmp/sardi
tar -zxf /tmp/sardi.tar.gz -C /tmp/sardi
rm /tmp/sardi.tar.gz
cp -rf /tmp/sardi/* ~/.icons/
ft_clean

#Sardi V4

git clone https://github.com/erikdubois/Sardi-Extra /tmp/Sardi-Extra
find /tmp/Sardi-Extra -maxdepth 1 -type f -exec rm -rf '{}' \;
cp -rf /tmp/Sardi-Extra/* ~/.icons/
ft_clean

#Tous les autres

for package in arc-gtk-theme ttf-font-awesome sardi-icons surfn-icons-git
do
	ft_install $package
done

echo    "################################################################"
echo    "#####################       Partie 4       #####################"
echo -e "################################################################\n"
echo -e "Dans cette section le script vous demandera confirmation pour installer d'autre outils (ide, navigateur...).\n"

for package in $ide $navigateur $discord $tweeter
do
	read -p "Voulez-vous installer $package ? oui/non : " answer
	if [ $answer = oui ];then
		if [ $package = discord-canary ];then
			ft_dependency
		else
			ft_install $package
		fi
	fi
done

read -p "Voulez-vous installer les parametre personels ? oui/non" answers2
if [ $answers2 = oui]; then
	sh Personal/personal-settings.sh
fi

echo "################################################################"
echo "###################  Fin de l'installation  ####################"
echo "################################################################"
