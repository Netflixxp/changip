提示：小白不知道什么是动态IP服务器的就不要用了，动态IP是台湾的hinet，香港的hkt等。其他机器都是静态IP，是换不了IP的。

# changip 全自动流媒体解锁监控 猴子修改版
一个可以监控Netflix被锁然后自动换IP的机器；仅对动态ip，通过api换ip的有效。脚本原作者为[yxkumad](https://github.com/yxkumad/streammonkeylite)。

# 功能
- 监控可换IP机器的IP是否被Netflix封了
- 如果封了，自动通过主机商提供的api更换ip
- 更换结果通过TG发送通知
- 更换后自动监测，如果还是被封，再次更换。
# 如何使用
* 1.下载脚本

    wget -O netflix.sh https://raw.githubusercontent.com/Netflixxp/changip/main/netflix.sh && chmod +x netflix.sh

* 2.修改netflix.sh

    vi netflix.sh

```# NAME=自己定义，例如HKT,注意保留引号
NAME="HKT"

# API=你更换IP的链接，每家不一样，自己替换，注意保留引号
API="htts://"

# TG_BOT_TOKEN=自行前往@Botfather获取,默认null

TG_BOT_TOKEN=null
# TG_CHATID=与机器人@userinfobot 对话,默认null
TG_CHATID=null
```


# TG机器人的申请

* TG_BOT_TOKEN的获取

telegram 中关注官方 @Botfather ，输入/newbot ，创建新的机器人（bot）时，会提供的 token（在提示 Use this token to access the HTTP API:后面一行）创建 bot 后，需要先在 telegram 中与 BOT 进行对话（随便发个消息），然后才可用 API 发送消息。

* TG_CHATID的获取

与机器人@userinfobot 对话可获得。

# 问题反馈
[TG频道](https://t.me/mffjc)

[TG群组](https://t.me/jcnfnatuo)
***

# [购买奈飞、YouTube正规合租车](https://jcnf.xyz/nf)
***

# 感谢
原作者[yxkumad](https://github.com/yxkumad/streammonkeylite)
