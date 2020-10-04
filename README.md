# KuliginStepan_infra
KuliginStepan Infra repository

bastion_IP = 130.193.49.130
someinternalhost_IP = 10.129.0.12

*Подключение к хосту во внутренней сети через bastion host:*

`ssh -i ~/.ssh/appuser -o ProxyCommand="ssh -W %h:%p -i  ~/.ssh/appuser appuser@130.193.49.130" appuser@10.129.0.12`

*Подключение к хосту во внутренней сети через bastion host с помощью команды `ssh someinternalhost`:*

Добавить в файл `~/.ssh/config`:

```
Host someinternalhost
   User appuser
   HostName 10.129.0.12
   IdentityFile ~/.ssh/appuser
   ProxyCommand ssh -W %h:%p -i ~/.ssh/appuser appuser@130.193.49.130
```

---

testapp_IP = 84.201.158.12
testapp_port = 9292

Команда для создания ВМ с приложением:
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1,ssh-keys='...' \
  --metadata-from-file user-data=cloud_config.sh
```

---

Создал образы reddit-base и reddit full, добавил скрипт автоматизации создания ВМ

`packer build -var-file=variables.json ./ubuntu16.json`
`packer build -var-file=variables.json ./immutable.json`

---
Создал ВМ с помощью terraform, добавил load balancer

Проблема при создании нескольких ВМ с помощьюю копирования кода в том, что такой подход не масштабируется.

---
Добавил terraform модули для приложения и базы данных, добавил remote backend на базе Yandex Object Storage.
