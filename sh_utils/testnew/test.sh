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
function banner() 
{
	line $1
    	echo -e "\r$IN_MIDDLE$COL_GREEN $1$COL_RESET "
}

function speak()
{
	line
	echo -e "\n\n $1\n"
	line
}

function action()
{
	echo -ne "$COL_YELLOW==> $1...$COL_RESET"
}

function ask()
{
	line
	echo -e "\n"
	read -p $'\e[34m'"$1 "$'\e[0m' answer
}


function ok() 
{
	calculate_position "ok"
	echo -e "\r$TO_RIGHT$COL_GREEN[ok]$COL_RESET"
}

function error() 
{
	calculate_position "error"
	echo -e "\r$TO_RIGHT$COL_RED[error]$COL_RESET" 
}
POSITION=$((`tput cols`-4))
TO_RIGHT_LOADER="\033["$POSITION"C"
function lance(){
  loading &
  pid=$!

  for i in `seq 1 5`
  do
    sleep 1
  done
  kill $pid >/dev/null 2>&1
}
function loading(){
	while [ 1 ] 
  do
    for i in ${ANIMATION[@]};
    do
      echo -ne "\r$TO_RIGHT_LOADER [$i";
      sleep 0.2;
    done;
  done
}


lance
ok


