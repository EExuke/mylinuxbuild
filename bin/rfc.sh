############################################################################# ##
# Copyright (C) 2010-2011 Cameo Communications, Inc.
############################################################################ ##
#
# -------------------------------------------------------------------------- --
#     AUTHOR                   : Zhendong Cao
#     FILE NAME                : rfc.sh
#     FILE DESCRIPTION         : Shell script look up for RFC files
#     FIRST CREATION DATE      : 2020/04/15
# --------------------------------------------------------------------------
#     Version                  : 1.0
#     Last Change              : 2020/04/15
## ************************************************************************** ##
#!/bin/sh
#-----------------------------------------------------------
#                COLOUR VARIABLES
#-----------------------------------------------------------
UNDL="\033[4m"    F6_E="\033[0m"    B_WT="\033[47m"
F_BL="\033[30m"   F_RD="\033[31m"   F_GR="\033[32m"
F_YL="\033[33m"   F_BU="\033[34m"   F_PU="\033[35m"
F_DG="\033[36m"   F_WT="\033[37m"   B_BL="\033[40m"
B_RE="\033[41m"   B_GR="\033[42m"   B_YL="\033[43m"
B_BU="\033[44m"   B_PR="\033[45m"   B_DG="\033[46m"

RFC_TXT_FOLDER=/home/xuke/mylinuxbuild/rfc
#-----------------------------------------------------------
#                RFC FUNCTIONS
#-----------------------------------------------------------
function rfc_help_info ()
{
    echo -e "${F_DG}rfc${F6_E} ${F_GR}[index]${F6_E}    : RFC index page for all of RFCs information
    ${F_GR}[search]${F6_E}   : Enter part of the content to find the corresponding RFC information
    ${F_GR}[update]${F6_E}   : Update to the latest RFC files from https://www.rfc-editor.org
    ${F_GR}[download]${F6_E} : Download the latest rfc text document through the command line
    ${F_GR}<RFC_ID>${F6_E}   : Open up to three RFC plain text documents with a specific RFC_ID"
}

function rfc_index ()
{
	local RFC_INDEX=$RFC_TXT_FOLDER/rfc-index.txt

	if [ -f $RFC_INDEX ];then
		vim $RFC_INDEX
	else
		echo -e $F_RD"ERROR: Cannot find the rfc-index.txt!"$F6_E
	fi
}

function rfc_download ()
{
	wget -c https://www.rfc-editor.org/in-notes/tar/RFC-all.zip -P $RFC_TXT_FOLDER/
}

function rfc_cover_index_to_one_line ()
{
	local DOS2UNIX=$(whereis dos2unix)
	local SW_EXIST=$(echo $DOS2UNIX | cut -d ':' -f2)
	local INDEX_TITLE=""

	if [ "$SW_EXIST" = "" ]
	then
		echo -ne $F_RD
		read -n 1 -p "dos2unix is required software, do you want to apt-install it?[y/n]: " op3
		echo -e $F6_E

		if [ "$op3" = "y" ]; then
			sudo apt-get install dos2unix
		else
			echo -e $F_RD"ERROR: Cannot find \'dos2unix\', $F_YL\"rfc search\"$F_RD cannot work well!"$F6_E
			return 1;
		fi
	fi

	# dos2unix rfc-index.txt
	dos2unix $RFC_TXT_FOLDER/rfc-index.txt &> /dev/null

	# cover to one line and remove unusful info from " (Format" ench line.
	sed -i '3d' $RFC_TXT_FOLDER/rfc-index.txt
	sed -ri ':1;N;/\n\s*+/s/\n\s+/ /g;t1;P;D' $RFC_TXT_FOLDER/rfc-index.txt
	sed -i 's/ (Format:.*$//g' $RFC_TXT_FOLDER/rfc-index.txt
}

function rfc_update ()
{
	if [ ! -f $RFC_TXT_FOLDER/RFC-all.zip ]
	then
		echo -e ${F_RD}No dependent file found in $RFC_TXT_FOLDER!
		read -n 1 -p "Do you want to download RFC-all.zip now? this will take you a few hours[y/n]: " op1
		echo -e $F6_E

		if [ "$op1" == "y" ]; then
			echo -e ${F_GR}"Downloading RFC-all.zip to $RFC_TXT_FOLDER..."$F6_E
			rfc_download
		else
			echo -e $F_YL"\nWARNING: Please download RFC-all.zip from https://www.rfc-editor.org/in-notes/tar/RFC-all.zip, and update again"$F6_E

			return 1;
		fi
	fi

	# Remove old txt if exist
	echo -e ${F_GR}"Removing old rfc*.txt from $RFC_TXT_FOLDER..."$F6_E
	rm -rf $RFC_TXT_FOLDER/rfc*.txt

	# unzip RFC-all.zip
	echo -e ${F_GR}"unzip RFC-all.zip..."$F6_E
	unzip $RFC_TXT_FOLDER/RFC-all.zip -d $RFC_TXT_FOLDER/RFC-all/ &> /dev/null
	if [ $? != 0 ]
	then
		echo -e $F_RD"ERROR: unzip $RFC_TXT_FOLDER/RFC-all.zip Failed!"$F6_E
		return 1
	fi

	# We just need rfc*.txt files
	echo -e ${F_GR}"Picking out only the required txt files..."$F6_E
	mv $RFC_TXT_FOLDER/RFC-all/rfc*.txt $RFC_TXT_FOLDER/
	rm -rf $RFC_TXT_FOLDER/RFC-all

	# Delete the front line of rfc_index.txt
	echo -e ${F_GR}"Rearranging rfc-index.txt..."$F6_E
	sed -i '1,7d;9,61d;64,65d' $RFC_TXT_FOLDER/rfc-index.txt

	# cover rfc-index information to one line,
	rfc_cover_index_to_one_line
	echo -e ${F_GR}"Done!"$F6_E
}

function rfc_format_show_list ()
{
	#  -----------------------------------------------------
	# |                Note of SHELL STR cut                |
	#  -----------------------------------------------------
	# | 1. ## / # : left -> right, so use '*<string>'       |
	# |                                                     |
	# |           ^                                         |
	# |    ## -- [去多留少], e,g. 12.123.34 -- {##*.} -- 34 |
	# |     # -- e,g. 12.123.34 -- {#*.} -- 123.34          |
	#  -----------------------------------------------------
	# | 2. %% / % : right -> left, so use '<string>*'       |
	# |                                                     |
	# |           ^                                         |
	# |    %% -- [去多留少], e,g. 12.123.34 -- {%%.*} -- 12 |
	# |     % -- e,g. 12.123.34 -- {%.*} -- 12.123          |
	#  -----------------------------------------------------
	local split=". "
	local LINE_NUM=""
	local SHOW_STR=""

	# Get the keywords
	local SUBJECT=${1%%${split}*}      # right -> left, keep before last '. '
	local STR_AFTER_SUB=${1#*${split}} # left -> right, keep after first '. '
	local DATE=${STR_AFTER_SUB##*${split}}      # left -> right, keep after last '. '
	local AUTHOR=${STR_AFTER_SUB%${split}*}     # right -> left, keep before first '. '

	# Format the FLAG which is line number
	if [ $FLAG -le 9 ];then
		LINE_NUM="000$FLAG"
	elif [ $FLAG -gt 9 ] && [ $FLAG -le 99 ];then
		LINE_NUM="00$FLAG"
	elif [ $FLAG -gt 99 ] && [ $FLAG -le 999 ];then
		LINE_NUM="0$FLAG"
	else
		LINE_NUM="$FLAG"
	fi

	# Format the DATE
	local DATE_MONTH=$(echo $DATE | cut -d ' ' -f1)
	local DATE_YEAR_STR=$(echo $DATE | cut -d ' ' -f2)
	local DATE_YEAR=${DATE_YEAR_STR%%.*}
	case $DATE_MONTH in
		January)
			DATE="$DATE_YEAR-01";;
		February)
			DATE="$DATE_YEAR-02";;
		March)
			DATE="$DATE_YEAR-03";;
		April)
			DATE="$DATE_YEAR-04";;
		May)
			DATE="$DATE_YEAR-05";;
		June)
			DATE="$DATE_YEAR-06";;
		July)
			DATE="$DATE_YEAR-07";;
		August)
			DATE="$DATE_YEAR-08";;
		September)
			DATE="$DATE_YEAR-09";;
		October)
			DATE="$DATE_YEAR-10";;
		November)
			DATE="$DATE_YEAR-11";;
		December)
			DATE="$DATE_YEAR-12";;
		*)
			;;
	esac

	# rebuild and color SHOW_STR for showing
	SHOW_STR="$LINE_NUM. ${F_DG}RFC${F6_E} ${F_YL}${SEARCH_ID}${F6_E}  \
		-- ${F_GR}${DATE}${F6_E}  \
		${F_PU}[ ${SUBJECT} ]${F6_E}  \
		- (${AUTHOR})"

	# Display the searched result
	echo -e ${SHOW_STR}
}

function rfc_search ()
{
	local SEARCH_ID=
	local SEARCH_STR=
	local FLAG=

	if [ "$2" = "" ]; then
		echo -e $F_RD"ERROR: Nothing to search for!"$F6_E
		return 1;
	fi

	grep -Iirns -- "$2" $RFC_TXT_FOLDER/rfc-index.txt > $RFC_TXT_FOLDER/tmp_search_result.txt

	if [ $? -eq 0 ]
	then
		FLAG=0
		while read LINE
		do
			# Remove the found line number
			SEARCH_STR=${LINE#*:}       # left -> right, keep after
			SEARCH_ID=${SEARCH_STR%% *} # left -> right, keep before
			SEARCH_STR=${SEARCH_STR#* } # left -> right, keep after

			if [ "$SEARCH_ID" != "" ];then
				FLAG=$((FLAG + 1))
				rfc_format_show_list "$SEARCH_STR"
			fi

		done < $RFC_TXT_FOLDER/tmp_search_result.txt
	else
		# not found by title or keywords
		echo -e $F_YL"No result of searching \"$2\"!"$F6_E
	fi

	rm -rf $RFC_TXT_FOLDER/tmp_search_result.txt
}

function rfc_open ()
{
	local index_1=$(echo -e "$1" | sed -r 's/0*([0-9])/\1/')
	local index_2=$(echo -e "$2" | sed -r 's/0*([0-9])/\1/')
	local index_3=$(echo -e "$3" | sed -r 's/0*([0-9])/\1/')
	local RFC_1=$RFC_TXT_FOLDER/rfc${index_1}.txt
	local RFC_2=$RFC_TXT_FOLDER/rfc${index_2}.txt
	local RFC_3=$RFC_TXT_FOLDER/rfc${index_3}.txt

	case $# in
		1)
			if [ -n "$(echo $1| sed -n "/^[0-9]\+$/p")" ];then
				if [ -f $RFC_1 ];then
					vim $RFC_1
				else
					echo -e $F_RD"ERROR: Cannot find the corresponding rfc file!"$F6_E
				fi
			else
				echo -e $F_RD"ERROR: The RFC ID must be integer!"$F6_E
			fi
			;;
		2)
			if [ -n "$(echo $1| sed -n "/^[0-9]\+$/p")" ] &&
			   [ -n "$(echo $2| sed -n "/^[0-9]\+$/p")" ];then
				if [ -f $RFC_1 ] && [ -f $RFC_2 ];then
					vim $RFC_1 $RFC_2
				else
					echo -e $F_RD"ERROR: Cannot find the corresponding rfc file!"$F6_E
				fi
			else
				echo -e $F_RD"ERROR: The RFC ID must be integer!"$F6_E
			fi
			;;
		3)
			if [ -n "$(echo $1| sed -n "/^[0-9]\+$/p")" ] &&
			   [ -n "$(echo $2| sed -n "/^[0-9]\+$/p")" ] &&
			   [ -n "$(echo $3| sed -n "/^[0-9]\+$/p")" ];then
				if [ -f $RFC_1 ] && [ -f $RFC_2 ] && [ -f $RFC_3 ];then
					vim $RFC_1 $RFC_2 $RFC_3
				else
					echo -e $F_RD"ERROR: Cannot find the corresponding rfc file!"$F6_E
				fi
			else
				echo -e $F_RD"ERROR: The RFC ID must be integer!"$F6_E
			fi
			;;
		*)
			echo -e $F_RD"ERROR: Support open 3 rfc files at most!"$F6_E
			;;
	esac
}

#-----------------------------------------------------------
#                 MAIN PROCESS
#-----------------------------------------------------------
# https://www.rfc-editor.org/
function rfc ()
{
	if [ "$1" != "" ]; then
		case $1 in
			-h|--help)
				rfc_help_info
				;;
			index)
				rfc_index
				;;
			search)
				rfc_search "$@"
				;;
			download)
				rfc_download
				;;
			update)
				rfc_update
				;;
			[0-9]*)
				rfc_open "$@"
				;;
			*)
				rfc_help_info
				;;
		esac
	else
		rfc_help_info
	fi
}

#-----------------------------------------------------------
#                COMPLETE SCRIPT
#-----------------------------------------------------------
__rfc () {
    local cur prev comps
    local flags='-h --help index search download update'

    _init_completion -n = || return

    case $prev in
        rfc)
            COMPREPLY=($(compgen -W '${flags[*]}' -- "$cur"));;
        * )
            COMPREPLY=($(compgen -W "" -- "$cur"));;
    esac
}

complete -F __rfc rfc
