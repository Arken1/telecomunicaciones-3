# DNS

| Servicio | Puerto |
| -------- | ------ |
| DNS      | `53`   |

## Servidor DNS

Servidores raiz en el mundo: 13
Busqueda; cache, servidor local, servidor raiz

### Comandos del servicios

```apache
service named status
service named start
service named restart
service named stop
```

### Named

Instalamos el kit de desarrollo `bind`

```apache
yum install bind-utils bind-libs bind-*
```

Una vez instala, iniciamos su configuracion

```apache
vim /etc/named.conf
```

```apache
options {
        listen-on port 53 { 127.0.0.1; 192.168.50.3;};
        ...
        ...
        allow-query     { localhost; 192.168.50.0/24; };

...

zone "servicios.com" IN {
        type master;
        file "servicios.com.fwd";
};

zone "100.168.192.in-addr.arpa" IN {
        type master;
        file "servicios.com.rev";
```

Hacemos una copia del archivo de configuracion named empy y le damos permisos

```apache
cp /var/named/named.empty /var/named/servicios.com.fwd
cp /var/named/named.empty /var/named/servicios.com.rev

chmod 755 /var/named/servicios.com.fwd
chmod 755 /var/named/servicios.com.rev
```

Configuramos las zonas directa

```apache
vim /var/named/servicios.com.fwd
```

```apache
$ORIGIN servicios.com.
$TTL 3H
@       IN      SOA     server.servicios.com. root@servicios.com. (
                                                0       ; serial
                                                1D      ; refresh
                                                1H      ; retry
                                                1W      ; expire
                                                3H )    ; minimum
@       IN      NS      server.servicios.com.

;host en la zona

server  IN      A       192.168.100.4
www     IN      CNAME   server
```

Hacemos lo mismo para la zona reversa

```apache
vim /var/named/servicios.com.rev
```

```apache
$ORIGIN 100.168.192.in-addr.arpa.
$TTL 3H
@       IN SOA  server.servicios.com. root@servicios.com. (
                                        0       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
@       IN NS   server.servicios.com.
;host en la zona

4       IN      PTR     server.servicios.com.
```

### Rutas generales

```apache
vim /etc/named.conf
vim /var/named/servicios.com.fwd
vim /var/named/servicios.com.rev
vim /var/named/miotrositio.com.fwd
```

## Configurar DNS en cliente

```apache
vim /etc/resolv.conf
```
