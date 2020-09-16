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
