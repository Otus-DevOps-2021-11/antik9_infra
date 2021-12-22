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

### Cloud TestApp

```
testapp_IP = 51.250.7.236
testapp_port = 9292
```

Provision machine from cloud-config script:

```bash
$ yc compute instance create \
    --zone ru-central1-a \
    --name reddit-app \
    --hostname reddit-app \
    --memory=4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
    --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
    --metadata 'serial-port-enable=1' \
    --metadata-from-file user-data=cloud-config-testapp
```
