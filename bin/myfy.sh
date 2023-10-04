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
#                  web词典方式的支持
#-----------------------------------------------------------
#bing 词典
bing_dictionary()
{
	url_bing="https://www.bing.com/dict/search"
	data="q=${*}&qs=n&form=Z9LH5&sp=-1&lq=0&pq=${*}&sc=8-5&sk=&cvid=7B1FABA297AD4B47819022CF2426F2D3&ghsh=0&ghacc=0&ghpl="

	content_line=`curl -s ${url_bing}"?"${data} | grep "<!--pc-->"`

	result=`echo ${content_line} | awk -F 'description" content="' '{print $2}' | awk -F '"' '{print $1}' | awk -F '，' '{print $NF}'`

	echo ""
	echo ${result}
}

#-----------------------------------------------------------
#                  API srcourse config
#-----------------------------------------------------------
#API_SRC="baidu"
#API_SRC="youdao"
API_SRC="bing"

#-----------------------------------------------------------
#                  参数定义
#-----------------------------------------------------------
HEADER="Content-Type:application/x-www-form-urlencoded"
HEADER_JSON="Content-Type:application/json"
CUR_TIME=`date +%s`
SALT=`uuid`
INPUT_STR="${*}"

# 输入判断
if [[ ${INPUT_STR} == "" ]]; then
	echo -e "${F_GR}Usage: fy <text|文本> ${C_ED}"
	exit 0
fi

# 转URL编码
input_ec=`echo -n ${INPUT_STR} | od -An -tx1 | tr -d '\n' | tr ' ' %`

# 判断中英文
echo ${INPUT_STR} | grep -qP '[^\x00-\x7F]'
if [[ $? -eq 0 ]]; then
	from="zh"
	to="en"
else
	from="en"
	to="zh"
fi

if [[ ${API_SRC} == "baidu" ]]; then
	#-----------------------------------------------------------
	#                  baidu Keys
	#-----------------------------------------------------------
	API_ADDR="https://fanyi-api.baidu.com/api/trans/vip/translate"
	APP_ID="20230908001809652"
	APP_KEY="Blsc9e5yvpHLO74JBztT"

	#-----------------------------------------------------------
	#                  百度参数组织
	#-----------------------------------------------------------
	#sign=MD5(appid + q + salt + 密钥)
	sign=`echo -n "${APP_ID}${INPUT_STR}${SALT}${APP_KEY}" | md5sum | awk '{print $1}'`

	data="q=${input_ec}&from=${from}&to=${to}&appid=${APP_ID}&salt=${SALT}&sign=${sign}"
elif [[ ${API_SRC} == "youdao" ]]; then
	#-----------------------------------------------------------
	#                  youdao Keys
	#-----------------------------------------------------------
	API_ADDR="https://openapi.youdao.com/api"
	APP_ID="6ad7ad0f6eb1a626"
	APP_KEY="XY1mSTnjn9CYu1eyvt8Elh2pRugczLzR"

	#-----------------------------------------------------------
	#                  有道参数组织
	#-----------------------------------------------------------
	#sign=sha256(应用ID + input + salt + curtime + 应用密钥)；
	#TODO: input的计算方式为：input=q前10个字符 + q长度 + q后10个字符（当q长度大于20）或 input=q字符串（当q长度小于等于20）；
	sign=`echo -n "${APP_ID}${INPUT_STR}${SALT}${CUR_TIME}${APP_KEY}" | sha256sum | awk '{print $1}'`
	signType="v3"
	from="auto"

	data="q=${input_ec}&from=${from}&to=${to}&appKey=${APP_ID}&salt=${SALT}&sign=${sign}&signType=${signType}&curtime=${CUR_TIME}"
elif [[ ${API_SRC} == "bing" ]]; then
	bing_dictionary ${input_ec}
	exit 0
fi

#-----------------------------------------------------------
#                   Run curl
#-----------------------------------------------------------
result=`curl -s ${API_ADDR} -H ${HEADER} -d ${data}`

#-----------------------------------------------------------
#                   Result analysis
#-----------------------------------------------------------
if [[ ${API_SRC} == "baidu" ]]; then
	echo ${result} | jq .trans_result[0]
elif [[ ${API_SRC} == "youdao" ]]; then
	if [[ ${to} == "en" ]]; then
		echo ${result} | jq -c .translation,.basic.explains,.web[]
	else
		echo ${result} | jq -c .translation,.basic.explains,.web[],.basic.wfs[].wf
	fi
fi

