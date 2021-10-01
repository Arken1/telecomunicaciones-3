$ORIGIN globalsatellite.com.
$TTL 3H
@       IN SOA primary.globalsatellite.com root@globalsatellite.com. (
                                        1002    ; serial
                                        3H      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
;Name Server Information
@       IN      NS      primary.globalsatellite.com.

;Secondary Name server
@       IN      NS      secondary.globalsatellite.com.

;IP address of Primary Name Server
primary         IN      A       192.168.100.5

;IP address of Secondary Name Server
secondary       IN      A       192.168.100.4

;IP address of firewall Server
firewall        IN      A       192.168.0.16

;IP address of Smartphone Server
smart           IN      A       192.168.0.12