# Trojan client with control commands [简体中文](./README.md) | English
Download [Release](https://github.com/YHPeter/Trojan-gfw-configuration-explanation/releases) Here! If there are any issue, please contact to me. 

**Notices: Do not copy the following code and error will be reported. JSON files are not supported to comment.**

# Trojan Server Configuration 

The official document has enough details, you can refer from it:

https://github.com/trojan-gfw/trojan/

https://github.com/trojan-gfw/trojan/wiki/Binary-&-Package-Distributions

Or searching for the all-in-one command.

## Configuration

### Write Trojan Service

```
nano /etc/systemd/system/trojan.service
or
vim /etc/systemd/system/trojan.service
```
Paste the following code into the text editor with some change: 
```
[Unit]
Description=trojan  
After=network.target  
   
[Service]
Type=simple  
ExecStart=/usr/local/bin/trojan -c "/usr/local/etc/trojan/config.json"  
ExecReload=  
ExecStop=/usr/local/bin/trojan
PrivateTmp=true  
   
[Install]  
WantedBy=multi-user.target
```
Need to change part of the content, ```/usr/local/bin/trojan``` is the adress of trojan application, ```/usr/local/etc/trojan/config.json``` is the adress of configuation of trojan.
```
ExecStart=/usr/local/bin/trojan -c /usr/local/etc/trojan/config.json
ExecStop=/usr/local/bin/trojan
```

**Connect your server by ssh to edit trojan program file**

SSH INPUT: ```systemctl status trojan``` Find server.conf or json file

```
OUTPUT:
Main PID: xxxx (trojan)
  CGroup: /system.slice/trojan.service
          └─2233 /usr/src/trojan/trojan -c /usr/src/trojan/server.conf
```

/usr/src/trojan/server.conf is the adress of configuration

```nano /usr/src/trojan/server.conf ``` Edit configuration 

```
{
    "run_type": "server",
    "local_addr":"0.0.0.0",
    "local_port": 8443,          //local moniter port, the same as '"remote_port": 8443,' in client.json
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "password"              //your password
                                //also can set lots of passwords
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/usr/src/trojan-cert/fullchain.cer",       //website ssl certificate (.cer, .pem)
        "key": "/usr/src/trojan-cert/private.key",          //website ssl key (.key)
    //Other are needless to change
}
```

```systemctl restart trojan``` resatrt trojan service


# Trojan Clinet 

The least offical release: https://github.com/trojan-gfw/trojan/releases

## Certificate

**Clinet in MacOS and Windows only needs certificate without key file!**

1. On certificate on local

SSH INPUT: ```systemctl status trojan``` Find server.conf or json file

```
OUTPUT:
Main PID: xxxx (trojan)
  CGroup: /system.slice/trojan.service
          └─2233 /usr/src/trojan/trojan -c /usr/src/trojan/server.conf
```

/usr/src/trojan/server.conf is the adress of configuration

```cat /usr/src/trojan/server.conf ``` Output the content

```
OUTPUT:
"ssl": {
      "cert": "/usr/src/trojan-cert/fullchain.cer",
      "key": "/usr/src/trojan-cert/private.key",
      "key_password": "",
```

Download ```/usr/src/trojan-cert/fullchain.cer``` to local trojan client folder and overwrite original one if exists.

2. Cerficate on the local

Copy to local trojan client folder and overwrite original one if exists.

## client.json Configuration
```
{
    "run_type": "client",
    "local_addr": "127.0.0.1",
    "local_port": 1080,                 //local moniter port, the same as 127.0.0.1:port in SwitchyOmega extension 
    "remote_addr": "www.server.com",    //website url, with on http(s)://
    "remote_port": 8443,                //remote server port, the same as '"local_port": 8443,' in server.conf
    "password": [
        "password"                      //password
    ],
    "log_level": 1,
    "ssl": {
        "verify": true,
        "verify_hostname": true,
        "cert": "fullchain.cer",        //the certificate name
        
    //without changing other code
}
```
Save changing after editing!!!

## Control commands (start and stop)

The details can visit master branch of this [project](https://github.com/YHPeter/Trojan-gfw-configuration)

Download [Release files](https://github.com/YHPeter/Trojan-gfw-configuration-explanation/releases), thay are designed for MacOS and Windows with control commands, also delete the useless files in offical releases.

# Trojan Server Common Commands

``` systemctl restart trojan ``` restart trojan service <br>
``` systemctl stop trojan ``` stop trojan service <br>
``` systemctl start trojan ``` run torjan service <br>
``` systemctl status trojan ``` trojan status <br>
``` systemctl status trojan -l ``` complete trojan stauts <br>
``` cat /usr/src/trojan/server.conf ``` trojan configuation <br>

**Wish you can star this，let more people know the real configuation instead of using all-in-one command!!!**
