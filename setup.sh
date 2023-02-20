#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 2
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 1

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

coreselect=''
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
END
chmod 644 /root/.profile

echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Alright good ... installation file is ready"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check permission : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted!"
else
red "Permission Denied!"
rm setup.sh > /dev/null 2>&1
sleep 10
exit 0
fi
sleep 3

mkdir -p /etc/anggun
mkdir -p /etc/anggun/theme
mkdir -p /var/lib/premium-script;
echo "IP=" >> /var/lib/crot-script/ipvps.conf;

if [ -f "/etc/xray/domain" ]; then
echo ""
echo -e "[ ${green}INFO${NC} ] Script Already Installed"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to install again ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm setup.sh
sleep 10
exit 0
else
clear
fi
fi

echo ""
wget -q https://raw.githubusercontent.com/annelyah23/snip/main/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear

yellow "Add Domain for vmess/vless/trojan dll"
echo " "
read -rp "Input ur domain : " -e pp
echo "$pp" > /root/domain
echo "$pp" > /root/scdomain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/xray/scdomain
echo "IP=$pp" > /var/lib/crot-script/ipvps.conf

#THEME RED
cat <<EOF>> /etc/anggun/theme/red
BG : \E[40;1;41m
TEXT : \033[1;31m
EOF
#THEME BLUE
cat <<EOF>> /etc/anggun/theme/blue
BG : \E[40;1;44m
TEXT : \033[1;34m
EOF
#THEME GREEN
cat <<EOF>> /etc/anggun/theme/green
BG : \E[40;1;42m
TEXT : \033[1;32m
EOF
#THEME YELLOW
cat <<EOF>> /etc/anggun/theme/yellow
BG : \E[40;1;43m
TEXT : \033[1;33m
EOF
#THEME MAGENTA
cat <<EOF>> /etc/anggun/theme/magenta
BG : \E[40;1;43m
TEXT : \033[1;33m
EOF
#THEME CYAN
cat <<EOF>> /etc/anggun/theme/cyan
BG : \E[40;1;46m
TEXT : \033[1;36m
EOF
#THEME CONFIG
cat <<EOF>> /etc/anggun/theme/color.conf
blue
EOF
    
#clear
#echo -e "\e[0;32mREADY FOR INSTALLATION SCRIPT...\e[0m"
#echo -e ""
#sleep 1
#Install SSH-VPN
echo -e "\e[0;32mINSTALLING SSH-VPN...\e[0m"
sleep 1
wget https://${Server_URL}/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
sleep 3
clear
echo -e "\e[0;32mINSTALLING XRAY CORE...\e[0m"
sleep 3
wget -q -O /root/xray.sh "https://${Server_URL}/xray.sh"
chmod +x /root/xray.sh
./xray.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
#Install SET-BR
echo -e "\e[0;32mINSTALLING SET-BR...\e[0m"
sleep 1
wget -q -O /root/set-br.sh "https://${Server_URL}/set-br.sh"
chmod +x /root/set-br.sh
./set-br.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear

#rm -rf /usr/share/nginx/html/index.html
#wget -q -O /usr/share/nginx/html/index.html "https://raw.githubusercontent.com/annelyah23/xyz/main/index.html"

cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/Jesanne87/Modi/main/Version_check_v2 )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps

# Version_check_v2
echo "1.0" > /home/ver
clear
echo ""
echo -e "${RB}      .============================================.${NC}"
echo -e "${RB}      |${NC}    ${CB}Installation Has Been Completed${NC}         ${RB}|${NC}"
echo -e "${RB}      '============================================'${NC}"
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "      ${RB}🚀 ${NC} ${WB}Premium Autoscript By JsPhantom ${NC} ${RB}🚀 ${NC}"
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "                  ${WB}»»» Info Xray «««${NC}"
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${GB}✅${NC} ${YB}Xray Vmess Ws Tls : 443${NC}   ${WB}|${NC}  ${GB}✅${NC} ${YB}Websocket (CDN) TLS : 443${NC}"
echo -e "  ${GB}✅${NC} ${YB}Xray Vless Ws Tls : 443${NC}   ${WB}|${NC}  ${GB}✅${NC} ${YB}Websocket (CDN) NTLS :80${NC}"
echo -e "  ${GB}✅${NC} ${YB}Xray Trojan Ws Tls : 443${NC}  ${WB}|${NC}  ${GB}✅${NC} ${YB}TCP XTLS :443${NC}"
echo -e "  ${GB}✅${NC} ${YB}Trojan TCP XTLS : 443${NC}     ${WB}|${NC}  ${GB}✅${NC} ${YB}TCP TLS : 443${NC}"
echo -e "  ${GB}✅${NC} ${YB}Trojan TCP : 443${NC}          ${WB}|${NC}"
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "           ${WB}»»» YAML Service Information «««${NC}          "
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${GB}✅${NC} ${YB}YAML XRAY VMESS WS${NC}"
echo -e "  ${GB}✅${NC} ${YB}YAML XRAY VLESS WS${NC}"
echo -e "  ${GB}✅${NC} ${YB}YAML XRAY TROJAN WS${NC}"
echo -e "  ${GB}✅${NC} ${YB}YAML XRAY TROJAN XTLS${NC}"
echo -e "  ${GB}✅${NC} ${YB}YAML XRAY TROJAN TCP${NC}"
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "             ${WB}»»» Server Information «««${NC}                 "
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${MB}♦️${NC} ${YB}Timezone           ${GB}: Asia/Kuala_Lumpur (GMT +8)${NC}"
echo -e "  ${MB}♦️${NC} ${YB}Fail2Ban           ${GB}: [ON]${NC}"
echo -e "  ${MB}♦️${NC} ${YB}Dflate             ${GB}: [ON]${NC}"
echo -e "  ${MB}♦️${NC} ${YB}IPtables           ${GB}: [ON]${NC}"
echo -e "  ${MB}♦️${NC} ${YB}Auto-Reboot        ${GB}: [ON]${NC}"
echo -e "  ${MB}♦️${NC} ${YB}IPV6               ${RB}: [OFF]${NC}"
echo -e ""
echo -e "  ${GB}✅${NC} ${YB}Autoreboot On 06.00 GMT +8${NC}"
echo -e "  ${GB}✅${NC} ${YB}Backup & Restore VPS Data${NC}"
echo -e "  ${GB}✅${NC} ${YB}Automatic Delete Expired Account${NC}"
echo -e "  ${GB}✅${NC} ${YB}Bandwith Monitor${NC}"
echo -e "  ${GB}✅${NC} ${YB}Check Login User${NC}"
echo -e "  ${GB}✅${NC} ${YB}Check Created Config${NC}"
echo -e "  ${GB}✅${NC} ${YB}Automatic Clear Log${NC}"
echo -e "  ${GB}✅${NC} ${YB}Media Checker${NC}"
echo -e "  ${GB}✅${NC} ${YB}DNS Changer${NC}"
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo -e "           ${WB}»»» Autoscript By JsPhantom «««${NC}             "
echo -e "${CB}————————————————————————————————————————————————————————${NC}"
echo ""
echo -e "   ${tyblue}Your VPS Will Be Automatical Reboot In 10 seconds${NC}"
rm /root/cf.sh >/dev/null 2>&1
rm /root/setup.sh >/dev/null 2>&1
rm /root/insshws.sh 
rm /root/update.sh
sleep 10
reboot
