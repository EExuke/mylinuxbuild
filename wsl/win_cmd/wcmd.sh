 ############################################################################# ##
 # Copyright (C) 2001-2022 Inhand Networks, Inc.
 ############################################################################ ##
 #
 # -------------------------------------------------------------------------- --
 #     AUTHOR                   : EExuke
 #     FILE NAME                : wcmd.sh
 #     FILE DESCRIPTION         : 查看CMD方式运行windows自带工具的命令
 #     FIRST CREATION DATE      : 2023/04/20
 # --------------------------------------------------------------------------
 #     Version                  : 1.0
 #     Last Change              : 2023/04/20
 ## ************************************************************************** ##
#!/bin/bash
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
#                  MAIN PROCESS
#-----------------------------------------------------------
WIN_TOOLS_CMD_1="
calc-----------启动计算器
certmgr.msc----证书管理实用程序
charmap--------启动字符映射表
chkdsk.exe-----Chkdsk磁盘检查
ciadv.msc------索引服务程序
cleanmgr-------垃圾整理
cliconfg-------SQL SERVER 客户端网络实用程序
Clipbrd--------剪贴板查看器
cmd.exe--------CMD命令提示符
compmgmt.msc---计算机管理
conf-----------启动netmeeting"
WIN_TOOLS_CMD_2="
dcomcnfg-------打开系统组件服务
ddeshare-------打开DDE共享设置
devmgmt.msc----设备管理器
dfrg.msc-------磁盘碎片整理程序
diskmgmt.msc---磁盘管理实用程序
drwtsn32-------系统医生
dvdplay--------DVD播放器
dxdiag---------检查DirectX信息"
WIN_TOOLS_CMD_3="
explorer-------打开资源管理器
eudcedit-------造字程序
eventvwr-------事件查看器"
WIN_TOOLS_CMD_4="
fsmgmt.msc-----共享文件夹管理器
gpedit.msc-----组策略
iexpress-------木马捆绑工具，系统自带
logoff---------注销命令
lusrmgr.msc----本机用户和组
notepad--------打开记事本"
WIN_TOOLS_CMD_5="
magnify--------放大镜实用程序
mem.exe--------显示内存使用情况
mmc------------打开控制台49.
mobsync--------同步命令
mplayer2-------简易widnows media player
Msconfig.exe---系统配置实用程序
mspaint--------画图板
mstsc----------远程桌面连接"
WIN_TOOLS_CMD_6="
narrator------------屏幕“讲述人”
net start messenger-开始信使服务
netstat -an---------(TC)命令检查接口
net stop messenger--停止信使服务
Nslookup------------IP地址侦测器 ，是一个监测网络中 DNS 服务器是否能正确实现域名解析的命令行工具.
ntbackup------------系统备份和还原
ntmsmgr.msc---------移动存储管理器
ntmsoprq.msc--------移动存储管理员操作请求"
WIN_TOOLS_CMD_7="
odbcad32---------ODBC数据源管理器
oobe/msoobe /a---检查XP是否激活
osk--------------打开屏幕键盘"
WIN_TOOLS_CMD_8="
packager-------对象包装程序
perfmon.msc----计算机性能监测程序
progman--------程序管理器"
WIN_TOOLS_CMD_9="
regedit.exe-------------注册表
regedt32----------------注册表编辑器
regsvr32 /u *.dll-------停止dll文件运行
regsvr32 /u zipfldr.dll-取消ZIP支持
rononce -p--------------15秒关机
rsop.msc----------------组策略结果集"
WIN_TOOLS_CMD_a="
secpol.msc-----本地安全策略
services.msc---本地服务设置
sfc.exe--------系统文件检查器
sfc /scannow---扫描错误并复原
sfc /scannow---windows文件保护
shrpubw--------创建共享文件夹
shutdown-------60秒倒计时关机命令
sigverif-------文件签名验证程序
sndrec32-------录音机
Sndvol32-------音量控制程序
syncapp--------创建一个公文包
sysedit--------系统配置编辑器
syskey---------系统加密，一旦加密就不能解开，保护windows系统的双重密码"
WIN_TOOLS_CMD_b="
taskmgr--------任务管理器
tourstart------xp简介（安装完成后出现的漫游xp程序）
utilman--------辅助工具管理器"
WIN_TOOLS_CMD_c="
wiaacmgr-------扫描仪和照相机向导
winchat--------局域网聊天
winmsd---------系统信息
winver---------检查Windows版本
write----------写字板
wmimgmt.msc----打开windows管理体系结构（WMI)
wscript--------windows脚本宿主设置
wupdmgr--------windows更新程序"

echo -e "${F_GR}windows tools cmd:${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_1}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_2}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_3}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_4}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_5}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_6}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_7}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_8}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_9}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_a}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_b}${C_ED}"
echo -e "${F_GR}${WIN_TOOLS_CMD_c}${C_ED}"

