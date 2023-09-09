#!/bin/bash
############################################################################# ##
# Copyright (C) 2001-2022 Inhand Networks, Inc.
############################################################################# ##
#
# -------------------------------------------------------------------------- --
#     AUTHOR                   : EExuke
#     FILE NAME                : myfy.sh
#     FILE DESCRIPTION         : 在线cli快速翻译脚本
#     FIRST CREATION DATE      : 2023/09/04
# --------------------------------------------------------------------------
#     Version                  : 1.0
#     Last Change              : 2023/09/04
## ************************************************************************** ##
#
#-----------------------------------------------------------
#                COLOUR VARIABLES
#-----------------------------------------------------------
C_ED="\033[0m"    C_HL="\033[01m"   C_UL="\033[04m"
C_BL="\033[05m"   C_RV="\033[07m"   C_HD="\033[08m"
C_SV="\033[s"     C_RE="\033[u"     C_CL="\033[2J"
C_LE="\033[K"
F_BL="\033[30m"   F_RD="\033[31m"   F_GR="\033[32m"
F_YL="\033[33m"   F_BU="\033[34m"   F_PU="\033[35m"
F_DG="\033[36m"   F_WT="\033[37m"
B_BL="\033[40m"   B_RE="\033[41m"   B_GR="\033[42m"
B_YL="\033[43m"   B_BU="\033[44m"   B_PR="\033[45m"
B_DG="\033[46m"   B_WT="\033[47m"

#-----------------------------------------------------------
#                  Keys
#-----------------------------------------------------------
API_ADDR="https://fanyi-api.baidu.com/api/trans/vip/translate"
APP_ID="20230908001809652"
APP_KEY="Blsc9e5yvpHLO74JBztT"

#HEADER="Content-Type:application/json"
HEADER="Content-Type:application/x-www-form-urlencoded"
SALT=`date +%s`
INPUT_STR="${*}"

# 转URL编码
input_ec=`echo -n ${INPUT_STR} | od -An -tx1 | tr -d '\n' | tr ' ' %`

#-----------------------------------------------------------
#                  MAIN PROCESS
#-----------------------------------------------------------
#sign=MD5(appid + q + salt + 密钥)
sign=`echo -n "${APP_ID}${INPUT_STR}${SALT}${APP_KEY}" | md5sum | awk '{print $1}'`

# 判断中英文
echo ${INPUT_STR} | grep -qP '[^\x00-\x7F]'
if [[ $? -eq 0 ]]; then
	# zh to en
	data="q=${input_ec}&from=zh&to=en&appid=${APP_ID}&salt=${SALT}&sign=${sign}&action=0"
else
	# en to zh
	data="q=${input_ec}&from=en&to=zh&appid=${APP_ID}&salt=${SALT}&sign=${sign}&action=0"
fi

#-----------------------------------------------------------
#                   run curl
#-----------------------------------------------------------
result=`curl -s ${API_ADDR} -H ${HEADER} -d ${data}`

#-----------------------------------------------------------
#                   result parase
#-----------------------------------------------------------
echo ${result} | jq .trans_result[0]

