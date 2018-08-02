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

#rows 

TAILLE=`tput cols`
PLACE=$(($TAILLE-6))

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function banner() {
	

	    NbrIter=$TAILLE

    for i in $(seq 0 $(($NbrIter-1)))
    do
        Iter=$Iter"#"
    done

    echo -n $Iter
    Iter=""

	MIDDLE=$(($TAILLE/2))
	NB_CARACT=`echo $1 | wc -c`
	NB_CARACT_2=$(($NB_CARACT/2))
	PLACE=$(($MIDDLE-$NB_CARACT_2))
    echo -e "\r\033["$PLACE"C $COL_GREEN$1$COL_RESET "
}


function ok() {
    echo -e "\r\033["$PLACE"C $COL_GREEN[ok]$COL_RESET "$1
}

function bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function running() {
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function action() {
    echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

function warn() {
    echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

function error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

clear
banner "S>DGQSDGSDQGSDQGSD" 
