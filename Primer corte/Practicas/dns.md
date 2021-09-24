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

### Rutas generales

```apache
vim /etc/named.conf
vim /var/named/servicios.com.fwd
vim /var/named/servicios.com.rev
```

## Configurar DNS en cliente

```apache
vim /etc/resolv.conf
```
