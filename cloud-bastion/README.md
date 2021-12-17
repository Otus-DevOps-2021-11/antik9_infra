# antik9_infra
antik9 Infra repository

### Cloud bastion

Connect to an internal host through the bastion:

```
$ ssh appuser@10.128.0.30 -J appuser@51.250.2.238:22
```

SSH config:

```
Host someinternalhost
    User appuser
    IdentityFile ~/.ssh/appuser
    Hostname 10.128.0.30
    ProxyCommand ssh bastion -W %h:%p

Host bastion
    User appuser
    IdentityFile ~/.ssh/appuser
    Hostname 51.250.2.238
    PubkeyAuthentication yes
```

Hosts:

```
bastion_IP = 51.250.2.238
someinternalhost_IP = 10.128.0.30
```
