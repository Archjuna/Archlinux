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


source ./speak.sh
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

