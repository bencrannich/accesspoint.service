# Access Point service

This is a Docker Compose stack that operates as a wireless access point,
via hostapd, isc-dhcpd, and bind9, each running in a Debian-based 
container.

The hostapd container (`ap`) is privileged as well as using host networking mode.

The `dhcpd` container uses host networking mode.

The `dns` container uses standard port forwarding.

This stack isn't really set up for others to make use of it but shared in
case it's interesting/somehow useful.

