
# Trojan客户端 集合运行和终止命令 简体中文 | [English](./README_EN.md)
## 下载[Release](https://github.com/YHPeter/Trojan-gfw-configuration-explanation/releases) 不要复制下面的代码会报错，json文件是不能注释
# Trojan服务器端

官方文档比较详细，直接参考官网: https://github.com/trojan-gfw/trojan/

https://github.com/trojan-gfw/trojan/wiki/Binary-&-Package-Distributions

或使用网上一件脚本（找不到可以联系我推荐）

## 配置文件讲解

**用ssh连接服务器，配置trojan服务器端**

在服务器端输入```systemctl status trojan```获取 server.conf 或 json 文件

```
OUTPUT:
Main PID: xxxx (trojan)
  CGroup: /system.slice/trojan.service
          └─2233 /usr/src/trojan/trojan -c /usr/src/trojan/server.conf
```

/usr/src/trojan/server.conf 是配置文件地址

```nano /usr/src/trojan/server.conf ```修改配置

```
{
    "run_type": "server",
    "local_addr":"0.0.0.0",
    "local_port": 8443,          //本地监听端口，要和客户端配置client.json里的"remote_port": 8443,一致，下面会讲的
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "password"              //你自己的密码
                                //可以设置多个密码
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/usr/src/trojan-cert/fullchain.cer",       //网页ssl证书申请的 cer, pem
        "key": "/usr/src/trojan-cert/private.key",          //网页ssl证书申请的 key
    //后面都不需要变
}
```

```systemctl restart trojan``` 重启trojan服务


# Trojan客户端
以下内容是基于对Linux, Macos, Windows有一定基础的讲解

最新版本的客户端在：https://github.com/trojan-gfw/trojan/releases

以下下主要讲解 MacOS 和 Windows配置

## 证书文件

**客户端只需要证书文件（pem,cer等），不需要key**

1. 本地没有证书文件

在服务器端输入```systemctl status trojan```获取 server.conf 或 json 文件

 ```
OUTPUT:
Main PID: xxxx (trojan)
  CGroup: /system.slice/trojan.service
          └─2233 /usr/src/trojan/trojan -c /usr/src/trojan/server.conf
```

  /usr/src/trojan/server.conf 是配置文件地址

```cat /usr/src/trojan/server.conf ``` 查看配置

```
OUTPUT:
"ssl": {
      "cert": "/usr/src/trojan-cert/fullchain.cer",
      "key": "/usr/src/trojan-cert/private.key",
      "key_password": "",
```

下载 ```/usr/src/trojan-cert/fullchain.cer``` 到本地trojan客户端文件夹

2. 本地有证书文件

移动证书文件到trojan客户端文件夹

## client.json 配置
```
{
    "run_type": "client",
    "local_addr": "127.0.0.1",
    "local_port": 1080,                 //本地监听端口，要和SwitchyOmega里的 127.0.0.1:port 端口保持一致
    "remote_addr": "www.server.com",    //服务器网址，不要加 http(s)://
    "remote_port": 8443,                //远程服务器的端口，对应了server.conf里的 "local_port": 443,
    "password": [
        "password"                      //密码
    ],
    "log_level": 1,
    "ssl": {
        "verify": true,
        "verify_hostname": true,
        "cert": "fullchain.cer",//上一步证书的名字
        
    //后面都不需要变
}
```
修改完后保存

## start&stop文件

下载本项目的release文件，为 MacOS 和 Windows 写入了start 和 stop 文件，并精简了官方release

# Trojan 服务器端常用命令

``` systemctl restart trojan ``` 重启trojan <br>
``` systemctl stop trojan ``` 停止trojan <br>
``` systemctl start trojan ``` 运行torjan <br>
``` systemctl status trojan ``` 查看当前trojan状态 <br>
``` systemctl status trojan -l ``` 查看当前trojan完整状态 <br>
``` cat /usr/src/trojan/server.conf ``` 查看trojan配置 <br>

**希望大家可以star，更让更多人了解真正的trojan配置，而不是使用一键脚本**
