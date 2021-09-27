# Firewall

## Contenido

- [Firewall](#firewall)
  - [Contenido](#contenido)
  - [Servidor Firewall ()](#servidor-firewall-)
    - [Comandos del servicios](#comandos-del-servicios)
    - [Primera estructura](#primera-estructura)
  - [Pa](#pa)
    - [Segunda version](#segunda-version)
      - [Reglas](#reglas)
      - [Redireccion https](#redireccion-https)
      - [Bloquear http](#bloquear-http)
      - [Mascaras](#mascaras)
      - [Habilitar los servicios](#habilitar-los-servicios)
      - [Ignorar etiquetas](#ignorar-etiquetas)
    - [Cliente](#cliente)
    - [Consultar](#consultar)
  - [Otros](#otros)
  - [Referencias](#referencias)

## Servidor Firewall ()

### Comandos del servicios

```apache
service firewalld start
service firewalld stop
service firewalld restart
service firewalld status
```

> [!CAUTION]
> Antes de iniciar la configuración del firewall, detenga el Network Manager

### Primera estructura

Establecemos tres servidores

```ruby
Vagrant.configure("2") do |config|
    config.vm.define :cliente do |cliente|
        cliente.vm.box = "bento/centos-7.9"
        cliente.vm.network :private_network, ip: "192.168.50.2"
        cliente.vm.hostname = "cliente"
    end
    config.vm.define :servidor do |servidor|
        servidor.vm.box = "bento/centos-7.9"
        servidor.vm.network :private_network, ip: "192.168.50.3"
        servidor.vm.hostname = "servidor"
    end
end
```

service NetworkManager stop
chkconfig NetworkManager off

vim /etc/sysctl.conf

...
net.ipv4.ip_forward = 1

sysctl -p

firewall-cmd --get-active-zones
firewall-cmd --get-zones
firewall-cmd --list-all-zones

firewall-cmd --zone=public --add-interface=eth0
firewall-cmd --zone=internal --add-interface=eth1

[root@localhost ~]# firewall-cmd --get-active-zones
internal
interfaces: eth1
public
interfaces: eth0

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eth0 -j MASQUERADE
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth0 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

firewall-cmd --direct --get-all-rules

firewall-cmd --zone=public --add-service=http
firewall-cmd --zone=public --add-service=https
firewall-cmd --zone=public --add-service=dns

firewall-cmd --zone=internal --add-service=http
firewall-cmd --zone=internal --add-service=https
firewall-cmd --zone=internal --add-service=dns

---

vim /etc/sysconfig/network

GATEWAY=192.168.100.3
service network restart

netstat -rn

---

## Pa

---

> [!IMPORTANT]
> firewall-cmd --zone=dmz --remove-interface=eth2 --permanent

firewall-cmd --zone=dmz --list-all

firewall-cmd --permanent --zone=dmz --add-interface=eth1

firewall-cmd --reload

firewall-cmd --zone=dmz --add-service=http --permanent
firewall-cmd --zone=dmz --add-service=https --permanent

firewall-cmd --reload

---

firewall-cmd --permanent --zone=internal --add-interface=eth2
firewall-cmd --reload
firewall-cmd --zone=internal --list-all

---

sudo firewall-cmd --zone=dmz --add-masquerade
sudo firewall-cmd --zone=internal --add-masquerade

ip route del default via 10.0.2.2 dev eth0 proto dhcp metric 100

firewall-cmd --zone=internal --permanent --add-forward-port=port=80:proto=tcp:toport=80:toaddr=192.168.100.4

firewall-cmd --zone=internal --add-service=http --permanent
firewall-cmd --zone=internal --add-service=https --permanent

firewall-cmd --reload

firewall-cmd --permanent --zone=dmz --add-masquerade
firewall-cmd --permanent --zone=internal --add-masquerade

D [^1]

### Segunda version

En la maquina Firewall verifique que el servicio http este instalado

```apache
yum instal httpd
```

#### Reglas

```apache
firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -o eth1 -j MASQUERADE
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i eth2 -o eth1 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth2 -m state --state RELATED,ESTABLISHED -j ACCEPT
firewall-cmd --reload
firewall-cmd --direct --get-all-rules
```

#### Redireccion https

En la maquina Firewall [^2]

```apache
firewall-cmd --permanent --zone=internal --add-forward-port=port=443:proto=tcp:toport=443:toaddr=192.168.100.4
firewall-cmd --permanent --zone=dmz --add-forward-port=port=443:proto=tcp:toport=443:toaddr=192.168.100.4

firewall-cmd --reload
firewall-cmd --zone=internal --list-all
```

Si es necesario borrar

```apache
firewall-cmd --permanent --zone=internal --remove-forward-port=port=80:proto=tcp:toport=80:toaddr=192.168.100.4
firewall-cmd --permanent --zone=internal --remove-forward-port=port=443:proto=tcp:toport=443:toaddr=192.168.100.4
firewall-cmd --permanent --zone=dmz --remove-forward-port=port=80:proto=tcp:toport=80:toaddr=192.168.100.4
firewall-cmd --permanent --zone=dmz --remove-forward-port=port=443:proto=tcp:toport=443:toaddr=192.168.100.4

...

firewall-cmd --reload
firewall-cmd --zone=internal --list-all
```

#### Bloquear http

sudo firewall-cmd --zone=dmz --add-rich-rule 'rule family="ipv4" source address="192.168.100.4" port port=80 protocol=tcp reject'

firewall-cmd --permanent --zone=dmz --add-icmp-block=echo-reply
firewall-cmd --permanent --zone=dmz --add-icmp-block=echo-request

firewall-cmd --zone=dmz --list-all

firewall-cmd --permanent --zone=dmz --add-forward-port=port=443:proto=tcp:toport=443:toaddr=192.168.100.4
firewall-cmd --reload

firewall-cmd --permanent --zone=dmz --add-icmp-block=echo-reply
firewall-cmd --permanent --zone=dmz --add-icmp-block=echo-request


#### Mascaras

```apache
firewall-cmd --permanent --zone=dmz --add-masquerade
firewall-cmd --permanent --zone=internal --add-masquerade
firewall-cmd --reload
firewall-cmd --zone=dmz --list-all
firewall-cmd --zone=internal --list-all
```

#### Habilitar los servicios

```apache
firewall-cmd --zone=internal --add-service=http --permanent
firewall-cmd --zone=internal --add-service=https --permanent
firewall-cmd --reload
firewall-cmd --zone=dmz --list-all
firewall-cmd --zone=internal --list-all
```


En el cliente

```apache
curl https://192.168.100.4/ -k
```

#### Ignorar etiquetas

```apache
/etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4-icpm_echo_ignore_all = 1

firewall-cmd --reload
```

### Cliente

### Consultar

```apache
vim /etc/sysconfig/network
```

Adicionar la gateway

```apache
...

GATEWAY=192.168.100.3
```

Se debe reiniciar el servicio, borrar la conpuerta por defecto de vagrant y verficar en la tabla

```apache
service network restart
route del -net 0.0.0.0 gw 10.0.2.2 netmask 0.0.0.0 dev eth0
netstat -rn
```

--

```apache
netstat -rn
route del -net 209.191.50.0 gw 0.0.0.0 netmask 255.255.255.0 dev eth1
ip route del default via 209.191.50.0/24 dev eth1 proto kernel scope link src 209.191.50.6 metric 101
```

---

```apache
firewall-cmd --permanent --zone=dmz --remove-forward-port=port=80:proto=tcp:toport=80:toaddr=192.168.100.4
```

## Otros

[^3]

## Referencias

[^1]: Profe
[^2]: [Reenvío rápido de puertos a través de iptables y firewalld](https://blog.anthonythielen.com/tiny-tip-port-forwading/)
[^3]: [Como borrar metricas de ip route](https://unix.stackexchange.com/questions/245208/modifying-existing-route-entry-in-linux)
