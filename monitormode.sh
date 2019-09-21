#!/bin/bash
green='\e[32m'
red='\e[31m'
end='\e[0m'
clear

echo "$green                                                                     
                                  ##                                  
 ###  ###                         ##                         ##       
 ###  ###                         ##                         ##       
 ###::###                                                    ##       
 ###  ###   :####    ##.####    ####      .####:    :#####.  ##.####  
 ## ## ##   ######   #######    ####     .######:  ########  #######  
 ##:##:##   #:  :##  ###  :##     ##     ##:  :##  ##:  .:#  ###  :## 
 ##.##.##    :#####  ##    ##     ##     ########  ##### .   ##    ## 
 ## ## ##  .#######  ##    ##     ##     ########  .######:  ##    ## 
 ##    ##  ## .  ##  ##    ##     ##     ##           .: ##  ##    ## 
 ##    ##  ##:  ###  ##    ##     ##     ###.  :#  #:.  :##  ##    ## 
 ##    ##  ########  ##    ##     ##     .#######  ########  ##    ## 
 ##    ##    ###.##  ##    ##     ##      .#####:  . ####    ##    ## 
                                 :##                                  
                               #####                                  
                               ####.   
"
if [ -z $1 ]
then 
  echo "Zero arguments passed"
  echo ""
  echo "Usage : sh monitomode.sh <interface>"
  exit 0
fi

printf "$green>>> Check if interface exists $end"
found=$(ip link show | grep $1)

if [ -z "$found" ]
then
   printf "$red : Didnt find $1 \n>>> exitting..\n"
   exit 0
else
   printf "$green : Found $1 \n"
fi

printf "$red>>> Warning: The interface $1 will be set to monitor-mode $end \n"
printf "$green>>> Bringing $1 down $end "
ifconfig $1 down
printf ": Success \n"

printf "$green>>> Enabling monitor mode on $1 $end "
iwconfig $1 mode monitor
printf ": Success \n"

printf "$green>>> Killing services using airomon-ng $end "
airmon-ng check kill

printf "$green>>> Bringing $1 up $end "
ifconfig $1 up
printf ": Success \n"
