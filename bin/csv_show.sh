#!/bin/bash
############################################################################# ##
# Copyright (C) 2019-2024 ZKLX Tech, Inc.
############################################################################ ##
#
# -------------------------------------------------------------------------- --
#     AUTHOR                   : EExuke
#     FILE NAME                : csv_show.sh
#     FILE DESCRIPTION         : 基于gnuplot实现的,csv文件数据可视化脚本工具
#     FIRST CREATION DATE      : 2024/09/12
# --------------------------------------------------------------------------
#     Version                  : 1.0
#     Last Change              : 2024/09/12
## ************************************************************************** ##

#-----------------------------------------------------------
#                CONTROL and COLOUR VARIABLES
#-----------------------------------------------------------
C_ED="\033[0m"    C_HL="\033[01m"   C_UL="\033[04m"
C_BL="\033[05m"   C_RV="\033[07m"   C_HD="\033[08m"
C_UP="\033[nA"    C_DW="\033[nB"    C_RI="\033[nC "
C_LE="\033[nD"    C_PS="\033[y;xH"  C_CL="\033[2J "
F_BL="\033[30m"   F_RD="\033[31m"   F_GR="\033[32m"
F_YL="\033[33m"   F_BU="\033[34m"   F_PU="\033[35m"
F_DG="\033[36m"   F_WT="\033[37m"   B_BL="\033[40m"
B_RE="\033[41m"   B_GR="\033[42m"   B_YL="\033[43m"
B_BU="\033[44m"   B_PR="\033[45m"   B_DG="\033[46m"
B_WT="\033[47m"

#-----------------------------------------------------------
#                  MAIN FUCNTIONS
#-----------------------------------------------------------
PAUSE_TIME=0.5

# 基础配置
config_base()
{
	echo -e '
	# 重置画面属性
	reset
	clear
	# 设置尺寸, 高宽比例
	#set size ratio 0.618
	# 设置图表标题和轴标签
	set title '"\"$1 Data Show\""'
	set title font ",14"
	set xlabel "point"
	set ylabel "val"
	# 设置刻度
	#set xtics 10
	#set mxtics 5
	# 设置网格
	set grid
	# 设置采样率
	#set samples 500
	# 设置CSV文件的分隔符
	set datafile separator ","
	'
}

# 点线风格设置, 查看图例方式: "gnuplot> test"
#linestyle 连线风格(包括linetype, linewidth等)
#linetype  连线种类
#linewidth 连线粗细
#linecolor 连线颜色
#pointtype 点的种类
#pointsize 点的大小
config_line()
{
	echo -e "with linespoints lw 0.5 pt 7 ps 0.7"
	#echo -e "smooth csplines lw 2"
}

run_gnuplot_data()
{
	case $# in
		1)
			echo -e "${F_RD}No data_cols selected!${C_ED}"
			;;
		2)
gnuplot << EOF
	`config_base $1`
	while (1) {
		plot   "$1" using $2 title "col$2" `config_line`
		pause ${PAUSE_TIME}
	}
EOF
			;;
		3)
gnuplot << EOF
	`config_base $1`
	while (1) {
		plot   "$1" using $2 title "col$2" `config_line`,\
			   "$1" using $3 title "col$3" `config_line`
		pause ${PAUSE_TIME}
	}
EOF
			;;
		4)
gnuplot << EOF
	`config_base $1`
	while (1) {
		plot   "$1" using $2 title "col$2" `config_line`,\
			   "$1" using $3 title "col$3" `config_line`,\
			   "$1" using $4 title "col$4" `config_line`
		pause ${PAUSE_TIME}
	}
EOF
			;;
		5)
gnuplot << EOF
	`config_base $1`
	while (1) {
		plot   "$1" using $2 title "col$2" `config_line`,\
			   "$1" using $3 title "col$3" `config_line`,\
			   "$1" using $4 title "col$4" `config_line`,\
			   "$1" using $5 title "col$5" `config_line`
		pause ${PAUSE_TIME}
	}
EOF
			;;
		6)
gnuplot << EOF
	`config_base $1`
	while (1) {
		plot   "$1" using $2 title "col$2" `config_line`,\
			   "$1" using $3 title "col$3" `config_line`,\
			   "$1" using $4 title "col$4" `config_line`,\
			   "$1" using $5 title "col$5" `config_line`,\
			   "$1" using $6 title "col$6" `config_line`
		pause ${PAUSE_TIME}
	}
EOF
			;;
		7)
gnuplot << EOF
	`config_base $1`
	while (1) {
		plot   "$1" using $2 title "col$2" `config_line`,\
			   "$1" using $3 title "col$3" `config_line`,\
			   "$1" using $4 title "col$4" `config_line`,\
			   "$1" using $5 title "col$5" `config_line`,\
			   "$1" using $6 title "col$6" `config_line`,\
			   "$1" using $7 title "col$7" `config_line`
		pause ${PAUSE_TIME}
	}
EOF
			;;
		*)
			echo -e "${F_RD}Not Supported, Please extend me!${C_ED}"
			;;
	esac
}

#-----------------------------------------------------------
#                  MAIN PROCESS
#-----------------------------------------------------------
if [[ $# < 2 ]]; then
	echo -e "${F_GR}Usage: $0 <file.csv> <data_cols: 1 2 3 ...> ${C_ED}"
else
	echo -e "${F_YL}file:$1, cols:${@:2} ${C_ED}"
	run_gnuplot_data $@
fi

