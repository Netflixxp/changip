#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

NAME=""
API=""
TG_BOT_TOKEN=
TG_CHATID=
COUNT=0
SESSION=/usr/local/bin/.netflix_session
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"

function Initialize {
    if [ -f $SESSION ]; then
        echo "发现 Session 文件，退出中"
        exit 0
    else
        echo "" > $SESSION
    fi
    echo -e "jcnf Netflix检测自动换ip 1.01版"
    echo -e "频道 https://t.me/mffjc"    
    Test
}

function Test {
    Netflix=$(curl --user-agent "${UA_Browser}" -4 -fsL --write-out %{http_code} --output /dev/null --max-time 30 "https://www.netflix.com/title/70143836" 2>&1)
    Analyse
}

function Analyse {
    if [[ "$Netflix" == "404" ]]; then
        NetflixResult="Originals Only"
    elif [[ "$Netflix" == "403" ]]; then
        NetflixResult="Banned"
    elif [[ "$Netflix" == "000" ]]; then
        NetflixResult="Network Error"
    elif [[ "$Netflix" == "200" ]]; then
        NetflixResult="Normal"
    else
        NetflixResult="Error"
    fi
    if [[ "$Netflix" == "404" ]] || [[ "$Netflix" == "403" ]]; then
        ChangeIP
    else
        AfterCheck
    fi
}

function ChangeIP {
    if [[ $COUNT -eq 0 ]]; then
        SendStartMsg
    fi
    let COUNT++
    echo "尝试更换 IP 中，次数: $COUNT"
    curl $API > /dev/null 2>&1
    sleep 5m
    Test
}

function AfterCheck {
    if [[ $COUNT -eq 0 ]]; then
        echo "状态正常，退出中"
        Terminate
    else
        SendEndMsg
        echo "成功更换 IP，退出中"
        Terminate
    fi
}

function SendStartMsg {
    TGMessage="jcnf %0A频道 https://t.me/mffjc%0A%0A解锁已失效%0A服务器：$NAME"
    curl -s -X POST "https://api.telegram.org/bot$TG_BOT_TOKEN/sendMessage" -d chat_id=$TG_CHATID -d text="$TGMessage" -d parse_mode="HTML" >/dev/null 2>&1
}

function SendEndMsg {
    TGMessage="jcnf %0A频道 https://t.me/mffjc%0A%0A已恢复解锁%0A服务器：$NAME%0A尝试次数：$COUNT"
    curl -s -X POST "https://api.telegram.org/bot$TG_BOT_TOKEN/sendMessage" -d chat_id=$TG_CHATID -d text="$TGMessage" -d parse_mode="HTML" >/dev/null 2>&1
}

function Terminate {
    rm -rf /usr/local/bin/.netflix_session
    exit 0
}

if [ "$1" == "1" ]; then
    echo -e "[手动] 定制版"
    echo -e "官网 https://zoecloud.cc"
    echo -e "频道 https://t.me/zoecloud"
    echo -e "群组 https://t.me/zoeclouds\n"
    FirstNetflixResult="Originals Only"
    FirstGoogle="CN"
    COUNT=1
    ChangeIP
else
    Initialize
fi
