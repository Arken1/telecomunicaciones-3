$ORIGIN 100.168.192.in-addr.arpa.
$TTL 3H
@       IN SOA primary.globalsatellite.com root@globalsatellite.com. (
                                        1002    ; serial
                                        3H      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
;Name Server Information
@      IN       NS      primary.globalsatellite.com.

;Secondary Name server
@      IN       NS      secondary.globalsatellite.com.

;IP address of Primary Name Server
5       IN      PTR     primary.globalsatellite.com.

;IP address of Secondary Name Server
4       IN      PTR     secondary.globalsatellite.com.

;IP address of Firewall Server
16      IN      PTR     firewall.globalsatellite.com.

;IP address of Secondary Name Server
12      IN      PTR     smart.globalsatellite.com.