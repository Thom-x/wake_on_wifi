#!/bin/bash

box_ip='192.168.1.1'
pc_mac='54:04:A6:3D:3F:AF'
phone_ip='192.168.1.11'
pc_ip='192.168.1.12'
last_phone_state=0
last_phone_lost=`date +%s`
last_phone_found=`date +%s`
delay=3600
info="NaN"

function display(){
	clear
	echo \##############################################################################
	echo \ 
	echo "           __      __    _          ___        __      ___  __ _ "
	echo "           \ \    / /_ _| |_____   / _ \ _ _   \ \    / (_)/ _(_)"
	echo "            \ \/\/ / _\` | / / -_) | (_) | ' \   \ \/\/ /| |  _| |"
	echo "             \_/\_/\__,_|_\_\___|  \___/|_||_|   \_/\_/ |_|_| |_|"
	echo "                                                                 "
	echo \ 
	echo \##############################################################################
	echo \ 
	echo \ \ \ BOX IP\ \ \ \ : $box_ip
	echo \ \ \ PHONE IP\ \ : $phone_ip
	echo \ \ \ PC IP\ \ \ \ \ : $pc_ip
	echo \ \ \ PC MAC\ \ \ \ : $pc_mac
	echo \ \ \ DELAY\ \ \ \ \ : $delay"s"
	echo \ 
	echo \ \ \ Last phone lose\ \ \ \ :  `date -d @$last_phone_lost`
	echo \ \ \ Last phone found\ \ \ : `date -d @$last_phone_found`
	if [ $last_phone_state = 0 ]
		then
		echo \ \ \ Signal lost for\ \ \ \ : $(($(date +%s)-$last_phone_lost))"s"
	else
		echo \ \ \ Signal lost for\ \ \ \ : 0s
	fi
	echo \ \ \ Log\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ : $info
	echo \ 
	echo \##############################################################################
}


while [ -n "1" ]
do
	display
	ping -c 1 $box_ip &> /dev/null
	if [ $? = 0 ]
		then
		#echo "Box found"
		ping -c 1 $phone_ip &> /dev/null
		if [ $? = 0 ]
			then
			#echo "Phone found"
			if [ $last_phone_state = 0 ]
				then
				last_phone_found=`date +%s`
			fi			
			if [ $(($(date +%s)-$last_phone_lost)) -gt $delay ] # signal lost for $delay just being found
				then
				if [ $last_phone_state = 0 ]
					then

					ping -c 1 $pc_ip &> /dev/null
					if [ $? = 1 ]
						then
						#echo "PC not found"
						info="Waking up PC : " `date` \n "Lose time : " $(($(date +%s)-$last_phone_lost))
						etherwake  $pc_mac
					fi
				fi
			fi
			last_phone_state=1
		else
			if [ $last_phone_state = 1 ]
				then
				last_phone_lost=`date +%s`
			fi
			last_phone_state=0
		fi
	fi
	sleep 10s
done
