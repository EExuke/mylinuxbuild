 ############################################################################# ##
 # Copyright (C) 2001-2020 Inhand Networks, Inc.
 ############################################################################ ##
 #
 # -------------------------------------------------------------------------- --
 #     AUTHOR                   : EExuke
 #     FILE NAME                : my_console.sh
 #     FILE DESCRIPTION         : Linux shell script file
 #     FIRST CREATION DATE      : 2021/05/10
 # --------------------------------------------------------------------------
 #     Version                  : 1.0
 #     Last Change              : 2021/05/10
 ## ************************************************************************** ##
#!/bin/bash
#-----------------------------------------------------------
#                COLOUR VARIABLES
#-----------------------------------------------------------
UNDL="\033[4m"    F6_E="\033[0m"    B_WT="\033[47m"
F_BL="\033[30m"   F_RD="\033[31m"   F_GR="\033[32m"
F_YL="\033[33m"   F_BU="\033[34m"   F_PU="\033[35m"
F_DG="\033[36m"   F_WT="\033[37m"   B_BL="\033[40m"
B_RE="\033[41m"   B_GR="\033[42m"   B_YL="\033[43m"
B_BU="\033[44m"   B_PR="\033[45m"   B_DG="\033[46m"

#-----------------------------------------------------------
#                  MAIN PROCESS
#-----------------------------------------------------------
PASSWD_1="root-^@(^5555@inhand"

PASSWD_2="64391099@inhand"

count=0

while [ true ]
	do
		#echo ${PASSWD_2} | xclip -selection clipboard
		#telnet 10.5.18.33;
		auto_login.exp
		sleep 3;
		count=$[${count}+1];
		if [[ 0 -eq ${count}%2 ]]; then
			gxmessage -center -fg green -font "Sans 12" -geometry 400x150 -buttons "OK" -title "my_console" "设备升级可能已完成!\n[${count}]";
		fi
		echo -e "${F_GR}auto reconnecting...${F6_E}";
	done

