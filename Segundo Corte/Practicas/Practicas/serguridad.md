# Servicios seguros

| Servidor | Puerto      |
| -------- | ----------- |
| http     | `80 / 5567` |
| https    | `80`        |
| sendmail | `25 / 465`  |
| imap     | `993`       |
| pop3     | `995`       |

## Contenido

- [Servicios seguros](#servicios-seguros)
  - [Contenido](#contenido)
  - [Configuracion del servidor](#configuracion-del-servidor)
  - [Sitio web seguro](#sitio-web-seguro)
    - [Instalación de paquete de servicios](#instalación-de-paquete-de-servicios)
    - [Creación de los certificados y las claves](#creación-de-los-certificados-y-las-claves)
      - [Generación de la clave privada](#generación-de-la-clave-privada)
      - [Generación de la petición de certificado (Certificate Signing Request = CSR)](#generación-de-la-petición-de-certificado-certificate-signing-request--csr)
      - [Generación del certificado](#generación-del-certificado)
    - [Configuración del modulo SSL y el servidor Web](#configuración-del-modulo-ssl-y-el-servidor-web)
  - [Correo seguro](#correo-seguro)
    - [Configuración de sendmail para aceptar los certificados y claves creados](#configuración-de-sendmail-para-aceptar-los-certificados-y-claves-creados)
    - [prueba de sendmail seguro](#prueba-de-sendmail-seguro)
    - [Enviar mensaje](#enviar-mensaje)
    - [Recibir mensaje](#recibir-mensaje)
  - [Referencias](#referencias)

## Configuracion del servidor

Se debe re direccionar el puerto http a un puerto anfitrion

```apache
Vagrant.configure("2") do |config|
  ...
  config.vm.define :<<servidor>> do |<<servidor>>|
    ...
    <<servidor>>.vm.network :forwarded_port, guest: 80, host:5567
    <<servidor>>.vm.network :forwarded_port, guest: 443, host:5568
    ...
  end
end
```

## Sitio web seguro

### Instalación de paquete de servicios

```apache
yum install openssl
```

### Creación de los certificados y las claves

#### Generación de la clave privada

Generamos un archivo tipo rsa con 1024 bit

```apache
openssl genrsa -out ca.key 1024
```

#### Generación de la petición de certificado (Certificate Signing Request = CSR)

```apache
openssl req -new -key ca.key -out ca.csr
```

Datos del certificado

```apache
Country Name (2 letter code) [XX]:CO
State or Province Name (full name) []:Valle del Cauca
Locality Name (eg, city) [Default City]:Cali
Organization Name (eg, company) [Default Company Ltd]:Universidad Autonoma de Occidente
Organizational Unit Name (eg, section) []:Automatica
Common Name (eg, your name or your server's hostname) []:servidor
Email Address []:miguel.rondon@uao.edu.co
```

#### Generación del certificado

Tipo x509

```apache
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt
```

Movemos los certificados a la direcciones correctas en modo root

```apache
cp ca.crt /etc/pki/tls/certs/
cp ca.key /etc/pki/tls/private/
cp ca.csr /etc/pki/tls/private/
```

> [!IMPORTANT]
> Asegurese de darle permisos de lectura y escritura de estos archivos solo a root
>
> ```apache
>  chmod 600 /etc/pki/tls/certs/ca.crt
>  chmod 600 /etc/pki/tls/private/ca.key
>  chmod 600 /etc/pki/tls/private/ca.csr
> ```

Tomado de [^1]

### Configuración del modulo SSL y el servidor Web

Se procede a configurar el modulo SSL. Para esto se debe editar el archivo de configuración de SSL:

```apache
/etc/httpd/conf.d/ssl.conf
```

En este archivo se debe indicar donde quedaron almacenados los archivos de
certificado y claves. Esto se hace modificando las siguientes directivas:

```apache
...
SSLCertificateFile /etc/pki/tls/certs/ca.crt
...
SSLCertificateKeyFile /etc/pki/tls/private/ca.key
...
```

Luego se debe modificar el archivo de configuración del servicio web:

```apache
/etc/httpd/conf/httpd.conf.
```

Agregue lo siguiente:

```apache
...

<VirtualHost *:443>
    SSLEngine On
    SSLCertificateFile /etc/pki/tls/certs/ca.crt

    SSLCertificateKeyFile /etc/pki/tls/private/ca.key
    DocumentRoot /var/www/html/
    ServerName www.nombre.com
</VirtualHost>

<VirtualHost *:80>
    SSLEngine Off
    DocumentRoot /var/www/html/
    ServerName www.nombre.com
</VirtualHost>
```

Por último se debe reiniciar el servicio httpd

```apache
m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
service sendmail restart
```

Verificamos el sitio web

[servicios.com](https://www.servicios.com/)

## Correo seguro

### Configuración de sendmail para aceptar los certificados y claves creados

Se procede a configurar en sendmail las opciones de SSL. Para esto se debe editar el archivo de configuración:

```apache
/etc/mail/sendmail.mc
```

En este archivo se debe indicar donde quedaron almacenados los archivos de certificado y claves. Esto se hace modificando las siguientes directivas (linea 60 aprox., borre el “dnl” que antecede a los comandos de ser necesario). Luego (alrededor de la línea 136) se debe habilitar el puerto que sendmail usará, que por defecto es el 465

```apache
... ~60
dnl #
define(`confCACERT_PATH', `/etc/pki/tls/certs')dnl
define(`confCACERT', `/etc/pki/tls/certs/ca-bundle.crt')dnl
define(`confSERVER_CERT', `/etc/pki/tls/certs/sendmail.pem')dnl
define(`confSERVER_KEY', `/etc/pki/tls/certs/sendmail.pem')dnl
dnl #

dnl #
define(`confCACERT_PATH', `/etc/pki/tls/certs')dnl
define(`confCACERT', `/etc/pki/tls/certs/ca.crt')dnl
define(`confSERVER_CERT', `/etc/pki/tls/certs/ca.crt')dnl
define(`confSERVER_KEY', `/etc/pki/tls/private/ca.key')dnl
dnl #

... ~136
dnl #
DAEMON_OPTIONS(`Port=smtps, Name=TLSMTA, M=s')dnl
dnl #
...
```

Se debe reiniciar el servicio

```apache
service sendmail restart
```

### prueba de sendmail seguro

Ingresamos al servidor desde una conexión telnet y ejecutamos el comando EHLO al servidor, debe responder de la siguiente manera (La línea 250-STARTTLS debe estar presente)

```apache
service sendmail restart
```

### Enviar mensaje

```apache
openssl s_client -crlf -connect server.servicios.com:465
helo server.servicios.com
mail from: mariamar@server.servicios.com
rcpt to: juangon@server.servicios.com
data
Subject:
asdas
.
```

### Recibir mensaje

Para enviar un mensaje usando SSL, puede usar el siguiente comando openssl

```apache
openssl s_client -crlf -connect server.servicios.com:465
```

Para recibir correo a través de IMAP usar el siguiente comando

```apache
openssl s_client -crlf -connect server.servicios.com:993
```

Para recibir correo a través de POP usar el siguiente comando

```apache
openssl s_client -crlf -connect server.servicios.com:995
```

## Referencias

[^1]: Andrew S. Tanenbaum. Redes de Computadoras. 2003
