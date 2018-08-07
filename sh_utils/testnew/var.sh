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
# Animation

ANIMATION=("|]" /] -] "\]")

# Position 

NB_ROWS=`tput cols`
MIDDLE_ROWS=$(($NB_ROWS/2))

# Colors

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function calculate_position()
{
	NB_CARACT=`echo $1 | wc -c`
	NB_CARACT_2=$(($NB_CARACT/2))
	PLACE=$(($MIDDLE_ROWS-$NB_CARACT_2))
	IN_MIDDLE="\033["$PLACE"C" 
	CALCUL_ROWS=$(($NB_ROWS-$NB_CARACT-1))
	TO_RIGHT="\033["$CALCUL_ROWS"C"
}

function line()
{
	calculate_position $1   	
	NbrIter=$NB_ROWS
    	for i in $(seq 0 $(($NbrIter-1)))
    	do
		Iter=$Iter"#"
    	done
    	echo -n $Iter
    	Iter=""
}
