#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

echo -e "jcnf Netflix检测自动换ip 1.00版 一键安装"
echo -e "频道 https://t.me/mffjc\n"  

localIP=$(ip -o -4 addr list | grep -Ev '\s(docker|lo)' | awk '{print $4}' | cut -d/ -f1 | grep -o "10.[0-9]\{1,3\}\.[0-9]\{1,3\}\.")

wget -O /usr/local/bin/netflix.sh https://raw.githubusercontent.com/Netflixxp/changip/main/netflix.sh>/dev/null 2>&1 && chmod +x /usr/local/bin/netflix.sh

echo -e "请输入服务器名称"
read -erp "(默认: jcnf):" name
[[ -z "$name" ]] && zoecloudname="jcnf"

echo -e "请输入 Telegram Bot Token 前往TG@Botfather"
read -erp "(默认: null):" bottoken
[[ -z "$bottoken" ]] && bottoken="null"

echo -e "请输入 Telegram Chat ID 前往TG@userinfobot"
read -erp "(默认: null):" botchatid
[[ -z "$botchatid" ]] && botchatid="null"

echo -e "请输入检测频率"
read -erp "(默认: 10):" crontime
[[ -z "$crontime" ]] && crontime="10"

echo -e "请输入换IP的api"
read -erp "(默认: null):" bottoken
[[ -z "$bottoken" ]] && bottoken="null"

sed -i "s/name/$name/g" /usr/local/bin/netflix.sh
sed -i "s/api/$api/g" /usr/local/bin/netflix.sh
sed -i "s/bottoken/$bottoken/g" /usr/local/bin/netflix.sh
sed -i "s/botchatid/$botchatid/g" /usr/local/bin/netflix.sh

crontab -l | { cat; echo "*/$crontime * * * * /usr/local/bin/netflix.sh >/dev/null 2>&1"; } | crontab -
