FROM debian:stable-slim AS base

WORKDIR /root

ENV LC_ALL C
ENV TZ=UTC
ENV DEBIAN_FRONTEND noninteractive

RUN echo 'APT::Install-Recommends "0"; \n\
APT::Install-Suggests "0"; \n\
APT::Get::Assume-Yes "true"; \n\
' > /etc/apt/apt.conf.d/noninteractive
ONBUILD RUN apt-get update

FROM base AS dhcpd

RUN apt-get install -y isc-dhcp-server

RUN touch /var/lib/dhcp/dhcpd.leases

CMD [ "/usr/sbin/dhcpd", "-4", "-f", "-d", "-cf", "/etc/dhcp/dhcpd.conf" ]
FROM base AS ap

RUN apt-get install -y hostapd

CMD ["/usr/sbin/hostapd", "-P", "/run/hostapd.pid", "/etc/hostapd/hostapd.conf"]

FROM base AS dns

RUN apt-get update -y && apt-get install -y bind9

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]

