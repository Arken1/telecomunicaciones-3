# Correo

## .Miguel Steven Rondon Salazar.  Universidad Autonoma de Occidente. Santiago de Cali - 2021

## Contenido

- [Correo](#correo)
  - [Contenido](#contenido)
  - [Que es](#que-es)
  - [sendmail](#sendmail)
    - [Instalación](#instalación)
    - [Configuración](#configuración)
    - [Enviar mensaje](#enviar-mensaje)
      - [Alias](#alias)
        - [Lista de alias](#lista-de-alias)
        - [Lista de grupos](#lista-de-grupos)
    - [DOVECOP](#dovecop)
      - [Intalación](#intalación)
      - [Visualizar mensajes](#visualizar-mensajes)
    - [IMAP](#imap)
  - [Ejemplo](#ejemplo)
  - [Referencias](#referencias)

## Que es

| Servicio | Puerto |
| -------- | ------ |
| sendmail | `25`   |

## sendmail

### Instalación

Instale el servicio `sendmail`

```apache
yum install sendmail sendmail-cf
```

```apache
service sendmail start
service sendmail stop
service sendmail restart
service sendmail status
```

### Configuración

```apache
ls /etc/mail/sendmail.\*
/etc/mail/sendmail.mc

cp /etc/mail/sendmail.mc /etc/mail/old.sendmail.mc
cp /etc/mail/sendmail.cf /etc/mail/old.sendmail.cf

vim /etc/mail/local-host-names

# local-host-names - include all aliases for your machine here.
```

```apache
servicios.com
server.servicios.com

vim /etc/mail/access

Connect:localhost.localdomain RELAY
Connect:localhost RELAY
Connect:127.0.0.1 RELAY
Connect:192.168.50 RELAY

makemap hash /etc/mail/access.db < /etc/mail/access

m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
```

### Enviar mensaje

> [!NOTE]
> Tomado de [^1]

Establezca una conexion al servicio

```apache
telnet example.com 25
```

Escriba ehlo example.com. Algunos servidores también aceptan helo en lugar de ehlo.

```apache
ehlo/helo example.com
```

Escriba el correo desde: username@example.com:

```apache
mail from: username@example.com
```

Escriba rcpt a: friend@hotmail.com, friend2@yahoo.com (reemplace con su nombre de destinatario real):

```apache
rcpt to: friend@hotmail.com, friend2@yahoo.com
```

Para escribir el mensaje, escriba datos, seguidos de su asunto y mensaje. Para finalizar el mensaje, coloque un punto en una línea por sí mismo y presione enter:

```apache
data
Subject: My Telnet Test Email

Hello,

This is an email sent by using the telnet command.

Your friend,
Me

.
```

Para ver mensaje en cola

```apache
mailq
```

forza el desencole de los mensajes:

```apache
sendmail -q
```

Escriba quit para salir de telnet.

#### Alias

```apache
/etc/aliases

newaliases
```

##### Lista de alias

| Usuario | alias  |
| ------- | ------ |
| pedrope | pperez |

##### Lista de grupos

| groupper |
| -------- |
| pedrope  |
| mariamar |

### DOVECOP

#### Intalación

Para instalar el servicio

```apache
yum install dovecop
```

Comandos utiles

```apache
service dovecot start
service dovecot stop
service dovecot restart
service dovecot status
```

Direcciones asociadas

```apache
/etc/dovecot/
vim dovecot.conf

vim /etc/dovecot/conf.d/10-mail.conf
vim /etc/dovecot/conf.d/10-auth.conf
vim /etc/dovecot/conf.d/10-ssl.conf
```

#### Visualizar mensajes

Establezca una conexion al servicio

```apache
telnet 127.0.0.1 110
```

Inicie sesion con un usuario

```apache
user <<username>>
pass <<password>>
```

Si desea verificar el numero de mensajes en el buzon

```apache
STAT
```

Si desea listar sus mensajes del buzon de entrada

```apache
LIST
```

Si desea leer un mensaje de correo electrónico como 2 5136, puede escribir lo siguiente:

```apache
retr <<#>>
```

Si desea eliminar un mensaje como 1 897, escriba:

```apache
dele <<#>>
```

Cuando haya terminado de revisar su correo electrónico, escriba salir.

```apache
quit
```

### IMAP

```apache
telnet 127.0.0.1 143
```

```apache
x LOGIN [user] [password]
x SELECT inbox
x FETCH (flags body[header.fields (subject)])
FETCH [#] (flags body[header.fields (subject)])
[#] FETCH (flags (/send) body[header.fields (subject)] {2})
FECTH [#] (body[text])
```

## Ejemplo

```sequence
Note left of Maria Martinez: mariamar
Maria Martinez->Pedro Perez: test 1
Note left of Pedro Perez: pedrope/pperez

groupper --> Maria Martinez: test 2
groupper --> Pedro Perez: test 2
Note left of Juan Gonzalez: juangon
Juan Gonzalez->groupper: test 2

```

---

## Referencias

[^1]: [SENDING OR VIEWING EMAILS USING TELNET](https://mediatemple.net/community/products/dv/204404584/sending-or-viewing-emails-using-telnet)
