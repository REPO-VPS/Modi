#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Geo Project
# (C) Copyright 2023
# =========================================
clear
###########- COLOR CODE -##############
colornow=$(cat /etc/JsPhantom/theme/color.conf)
export NC="\e[0m"
export YELLOW='\033[0;33m';
export RED="\033[0;31m" 
export COLOR1="$(cat /etc/JsPhantom/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
export COLBG1="$(cat /etc/JsPhantom/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')" 
WH='\033[1;37m'                   
###########- END COLOR CODE -##########
bold=$(tput bold)
normal=$(tput sgr0)
P='\e[0;35m'
B='\033[0;36m'
G='\e[0;32m'
N='\e[0m'
export Server_URL="raw.githubusercontent.com/Jesanne87/Modi/main"

clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(wget -qO- ipv4.icanhazip.com);
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
clear
domain=$(cat /root/domain)

# // nginx status
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // xray status
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

# // script version
myver="$(cat /home/ver)"

# // script version check
serverV=$( curl -sS https://${Server_URL}/version_check_v2)

function updatews(){
clear
echo -e "[ ${GREEN}INFO${NC} ] Check for Script updates . . ."
sleep 2
cd
wget -q -O /root/update-v2.sh "https://raw.githubusercontent.com/Jesanne87/Modi/main/update-v2.sh" && chmod +x update-v2.sh && ./update-v2.sh
sleep 2
rm -f /root/update-v2.sh
rm -f /home/ver
sleep 1
version_check_v2=$( curl -sS https://${Server_URL}/version_check_v2)
echo "$version_check_v2" >> /home/ver
clear
echo ""
echo -e "[ ${GREEN}INFO${NC} ] Successfully Up To Date!"
sleep 1
echo ""
read -n 1 -s -r -p "Press any key to continue..."
menu
}
clear
echo -e "$COLOR1???======================================================???${NC}"  
echo -e "\033[0;36m|${NC}\033[0;33m${bold}     _    ${NC}\033[0;34m${bold} ____ ${NC}${bold} _               ${NC}${bold}  _                 ${NC} \033[0;36m${bold}|${NC}" 
echo -e "\033[0;36m|${NC}\033[0;33m${bold}    | |___${NC}\033[0;34m${bold}|  _  ${NC}${bold}| |__ ${NC}\033[0;31m${bold}  __ _${NC}${bold} _ __ | |_${NC}\033[0;31m${bold} ___ ${NC}${bold} _ __ ___  ${NC}\033[0;36m${bold}|${NC}"
echo -e "\033[0;36m|${NC}\033[0;33m${bold} _  | / __${NC}\033[0;34m${bold}| |_) ${NC}${bold}|  _ |${NC}\033[0;31m${bold} / _  ${NC}${bold}|  _ \| __${NC}\033[0;31m${bold}/ _  ${NC}${bold}|  _   _ \ ${NC}\033[0;36m${bold}|${NC}"
echo -e "\033[0;36m|${NC}\033[0;33m${bold}| |_| \__ ${NC}\033[0;34m${bold}\  __/${NC}${bold}| | | ${NC}\033[0;31m${bold}| (_| ${NC}${bold}| | | | ||${NC}\033[0;31m${bold} (_) ${NC}${bold}| | | | | |${NC}\033[0;36m${bold}|${NC}"
echo -e "\033[0;36m|${NC}\033[0;33m${bold} \___/|___${NC}\033[0;34m${bold}/_|   ${NC}${bold}|_| |_${NC}\033[0;31m${bold}|\__,_${NC}${bold}|_| |_|\__${NC}\033[0;31m${bold}\___/${NC}${bold}|_| |_| |_|${NC}\033[0;36m${bold}|${NC}"
echo -e "$COLOR1???======================================================???${NC}"
echo -e "     $COLOR1      MULTIPORT WEBSOCKET BY ${NC}\033[0;33m${bold}JsPhantom \033[0m"
echo -e "$COLOR1???======================================================???${NC}"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e "$COLOR1${NC} ${COLBG1}                     ${WH}INFO SERVER ${NC}     $COLOR1         ${NC}"
echo -e "$COLOR1???======================================================???\033[0m"
load_cpu=$(printf '%-3s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
ram_used=$(free -m | grep Mem: | awk '{print $3}')
total_ram=$(free -m | grep Mem: | awk '{print $2}')
ram_usage=$(echo "scale=2; ($ram_used / $total_ram) * 100" | bc | cut -d. -f1)
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
IPVPS=$(curl -s icanhazip.com/ip )
daily_usage=$(vnstat -d --oneline | awk -F\; '{print $6}' | sed 's/ //')
monthly_usage=$(vnstat -m --oneline | awk -F\; '{print $11}' | sed 's/ //')
if [ "$cekup" = "day" ]; then
echo -e " \033[0;33m${bold}System Uptime      \033[0;32m:  ${bold}$uphours $upminutes $uptimecek"
else
echo -e " \033[0;33m${bold}System Uptime      \033[0;32m:  ${bold}$uphours $upminutes"
fi
echo -e " \033[0;33m${bold}Memory Usage       \033[0;32m:  ${bold}${ram_used}MB / ${total_ram}MB (${ram_usage}%)"
echo -e " \033[0;33m${bold}CPU Load           \033[0;32m:  ${bold}$load_cpu"
echo -e " \033[0;33m${bold}Kernel          \033[0;32m   :  ${bold}$(  uname -r) "
echo -e " \033[0;33m${bold}VPN Core           \033[0;32m:  ${bold}Xray-Core"
echo -e " \033[0;33m${bold}ISP                \033[0;32m:  ${NC}\033[0;34m${bold}$(curl -s ipinfo.io/org | cut -d " " -f 2-10)"
echo -e " \033[0;33m${bold}Domain          \033[0;32m   :  ${bold}\033[0;34m${bold}$domain"
echo -e " \033[0;33m${bold}IP Address      \033[0;32m   :  ${NC}\033[0;34m${bold}$IPVPS"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e "          [ XRAY-CORE${NC} : ${status_xray} ]   [ NGINX${NC} : ${status_nginx} ]"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e " ${bold}Daily Data Usage   :  ${bold}${yell}$daily_usage${N}"
echo -e " ${bold}Monthly Data Usage :  ${bold}${yell}$monthly_usage${N}"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e "$COLOR1{NC} ${COLBG1}                ${WH}      ${bold}XRAY MENU${NC}  COLOR1                \033[0m"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e " ${NC}[\033[1;36m${bold}???1\033[0m]  \033[0;32m${bold}Vmess WS Panel    ${NC}[\033[1;36m${bold}???4\033[0m]  \033[0;32m${bold}Trojan TCP XTLS Panel"
echo -e " ${NC}[\033[1;36m${bold}???2\033[0m]  \033[0;32m${bold}Vless WS Panel    ${NC}[\033[1;36m${bold}???5\033[0m]  \033[0;32m${bold}Trojan TCP Panel"     
echo -e " ${NC}[\033[1;36m${bold}???3\033[0m]  \033[0;32m${bold}Trojan WS Panel"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e "$COLOR1 {NC}${COLBG1}              ${WH}       OTHERS MENU ${NC}       COLOR1         \033[0m"
echo -e "$COLOR1???======================================================???\033[0m"
echo -e " ${NC}[\033[1;36m???7 \033[0m] ${NC} \033[0;32m${bold}Install Ads Block   ${NC}[\033[1;36m???16\033[0m]  ${NC}\033[0;32m${bold}Check VPN Port"
echo -e " ${NC}[\033[1;36m???9 \033[0m] ${NC} \033[0;32m${bold}Ads Block Panel     ${NC}[\033[1;36m???17\033[0m]  ${NC}\033[0;32m${bold}Restart VPN Services"
echo -e " ${NC}[\033[1;36m???10\033[0m] ${NC} \033[0;32m${bold}DNS Changer         ${NC}[\033[1;36m???18\033[0m]  ${NC}\033[0;32m${bold}Speedtest VPS"
echo -e " ${NC}[\033[1;36m???11\033[0m] ${NC} \033[0;32m${bold}Netflix Checker     ${NC}[\033[1;36m???20\033[0m]  ${NC}\033[0;32m${bold}Check Bandwith"
echo -e " ${NC}[\033[1;36m???12\033[0m] ${NC} \033[0;32m${bold}Limit Bandwith Speed${NC}[\033[1;36m???21\033[0m]  ${NC}\033[0;32m${bold}Backup"
echo -e " ${NC}[\033[1;36m???13\033[0m] ${NC} \033[0;32m${bold}Change Domain       ${NC}[\033[1;36m???22\033[0m]  ${NC}\033[0;32m${bold}Restore"
echo -e " ${NC}[\033[1;36m???14\033[0m] ${NC} \033[0;32m${bold}Renew Certi XRAY    ${NC}[\033[1;36m???23\033[0m]  ${NC}\033[0;32m${bold}Reboot"
echo -e " ${NC}[\033[1;36m???15\033[0m] ${NC} \033[0;32m${bold}Check VPN Status    ${WH}[${COLOR1}25${WH}]${NC} ${COLOR1}??? ${WH}THEME    ${WH}[${COLOR1}Menu${WH}]  $COLOR1 $NC"
if [[ $serverV > $myver ]]; then
echo -e " ${NC}[\033[1;36m???24\033[0m]  ${bold}Update Autoscript To $serverV\n"
up2u="updatews"
else
up2u="menu"
fi
echo -e " \033[1;37m${bold}Type [ x ] To Exit From Menu \033[0m"
echo ""
echo -e "$COLOR1???======================================================???\033[0m"
echo -e " ${bold}Version       : \033[0;32m${bold}Multiport Websocket $myver\e[0m"
echo -e " ${bold}Client Name   : $Name"
echo -e " ${bold}Expiry Script : $Exp"
echo -e " ${bold}Status Script : ${G}${bold}Lifetime${NC}"
echo -e "$COLOR1???======================================================???\033[0m"
echo ""
echo -ne " ${bold}Select menu : "; read opt
case $opt in
1) clear ; menu-ws ; read -n1 -r -p "Press any key to continue..." ; menu ;;
2) clear ; menu-vless ; read -n1 -r -p "Press any key to continue..." ; menu ;;
3) clear ; menu-tr ; read -n1 -r -p "Press any key to continue..." ; menu ;;
4) clear ; menu-xrt ; read -n1 -r -p "Press any key to continue..." ; menu ;;
5) clear ; menu-xtr ; read -n1 -r -p "Press any key to continue..." ; menu ;;
6) clear ; wssgen ; read -n1 -r -p "Press any key to continue..." ; menu ;;
7) clear ; ins-helium ; read -n1 -r -p "Press any key to continue..." ; menu ;;
8) clear ; bbr ; menu ;;
9) clear ; helium ; menu ;;
10) clear ; dns ; echo "" ; menu ;;
11) clear ; nf ; echo "" ; read -n1 -r -p "Press any key to continue..." ; menu ;;
12) clear ; limit ; echo "" ; menu ;;
13) clear ; add-host ; menu ;;
14) clear ; certxray ; menu ;;
15) clear ; status ; read -n1 -r -p "Press any key to continue..." ; menu ;;
16) clear ; info ; read -n1 -r -p "Press any key to continue..." ; menu ;;
17) clear ; restart ; menu ;;
18) clear ; speedtest ; echo "" ; read -n1 -r -p "Press any key to continue..." ; menu ;;
19) clear ; ram ; echo "" ; read -n1 -r -p "Press any key to continue..." ; menu ;;
20) clear ; vnstat ; echo "" ; read -n1 -r -p "Press any key to continue..." ; menu ;;
21) clear ; backup ; read -n1 -r -p "Press any key to continue..." ; menu ;;
22) clear ; restore ; menu ;;
23) clear ; reboot ;;
25) clear ; menu-theme ; read -n1 -r -p "Press any key to continue..." ; menu ;;
24) clear ; $up2u ; read -n1 -r -p "Press any key to continue..." ; menu ;;

00 | 0) clear ; menu ;;
x | X) exit ;;
*) clear ; menu ;;
esac
