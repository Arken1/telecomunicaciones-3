echo "Parar servicios"

service NetworkManager stop
chkconfig NetworkManager off

echo "Intalar Vim"

sudo yum install vim -y

echo "Iniciar firewalld"

service firewalld start

echo "Configuración del archivo systcl.conf - Redireccion de paquetes"

sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "Zonas DMZ / INTERNAL"
ifconfig eth1 192.168.0.16
firewall-cmd --set-default-zone=dmz
firewall-cmd --zone=dmz --add-interface=eth1
firewall-cmd --zone=internal --add-interface=eth2

firewall-cmd --zone=dmz --add-masquerade
firewall-cmd --zone=internal --add-masquerade


echo "Servicios en zonas dmz e internal"

firewall-cmd --zone=dmz --add-service=ftp
firewall-cmd --zone=dmz --add-service=dns

firewall-cmd --zone=internal --add-service=ftp
firewall-cmd --zone=internal --add-service=dns

echo "Redireccion de puertos"

firewall-cmd --zone=dmz --add-forward-port=port=21:proto=tcp:toport=21:toaddr=192.168.100.4
firewall-cmd --zone=dmz --add-forward-port=port=53:proto=udp:toport=53:toaddr=192.168.100.4
firewall-cmd --zone=dmz --add-forward-port=port=9122:proto=tcp:toport=22:toaddr=192.168.100.4

echo "apertura de puerto 21"

firewall-cmd --zone=dmz --add-port=20/tcp
firewall-cmd --zone=dmz --add-port=21/tcp
firewall-cmd --zone=dmz --add-port=53/udp
firewall-cmd --zone=dmz --add-port=912/tcp