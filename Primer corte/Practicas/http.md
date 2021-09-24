# HTTP

| Servidor | Puerto |
| -------- | ------ |
| httpd    | `80`   |

## Contenido

- [HTTP](#http)
  - [Contenido](#contenido)
  - [Servidor HTTPD ()](#servidor-httpd-)
    - [Comandos del servicios](#comandos-del-servicios)
    - [Consultas en Cliente](#consultas-en-cliente)
    - [Archivos de configuración](#archivos-de-configuración)
    - [Sitios habilitados/desabilitados](#sitios-habilitadosdesabilitados)
    - [Paginas creadas](#paginas-creadas)
      - [www.servicios.com](#wwwservicioscom)
      - [miotrositio.com](#miotrositiocom)
    - [Usuarios](#usuarios)
      - [Creados](#creados)
      - [Crear](#crear)
      - [Usuarios creados](#usuarios-creados)
  - [Referencias](#referencias)

## Servidor HTTPD ()

### Comandos del servicios

```apache
service httpd status
service httpd start
service httpd restart
service httpd stop
```

### Consultas en Cliente

```apache
wget --http-user=[name_user] --http-password=[name_user] www.servicios.com/protegido/pagina.html
curl -u [name_user]:[name_user] www.servicios.com/protegido/pagina.html
```

### Archivos de configuración

```apache
vim /etc/httpd/conf/httpd.conf
vim /etc/httpd/conf.d/userdir.conf
```

### Sitios habilitados/desabilitados

```apache
vim /etc/httpd/sites-enabled/
vim /etc/httpd/sites-available/
```

### Paginas creadas

#### www.servicios.com

```apache
vim /var/www/html
vim /var/www/html/inventario
vim /var/www/html/clientes
vim /var/www/html/clientes/.htaccess
vim /var/named/miotrositio.com.fwd        <- DNS
```

#### miotrositio.com

```apache
vim /var/www/miotrositio.com/public
vim /etc/httpd/sites-available/miotrositio.com.conf
```

### Usuarios

#### Creados

```apache
vim /home/httpd/juangon/public_html/
vim /home/httpd/mariamar/public_html/
vim /home/httpd/pedrope/public_html/
```

#### Crear

```apache
vim htpasswd [-c] /etc/httpd/claves user
```

#### Usuarios creados

```apache
vim /etc/httpd/conf/httpd.conf
```

htccess

## Referencias

[PROTEGER CARPETAS EN APACHE CON .HTACCESS](https://www.todavianose.com/proteger-carpetas-en-apache-con-htaccess/)

wget --http-user=admin --http-password=1234 www.servicios.com/inventario
