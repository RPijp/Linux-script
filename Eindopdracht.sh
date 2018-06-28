#!/bin/sh
# Your commands go under this line

#instal monitoring in de form van Cacti


apt-get update
apt-get upgrade

apt-get install snmpd snmp mysql-server apache2 libapache2-mod-php5 \
php5-mysql php5-cli php5-snmp

apt-get install cacti -y

apt-get install snmp snmpd -y

#####
apt-get install cacti-spine -y
#####

#instal logs in de vorm van Syslog-NG

sudo apt install syslog-ng -y

cat <<EOT >> /etc/syslog/syslog-ng.conf
@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
        options {
                time-reap(30);
                mark-freq(10);
                keep-hostname(yes);
                };
        source s_local { system(); internal(); };
        source s_network {
                syslog(transport(tcp) port(514));
                };
        destination d_local {
        file("/var/log/syslog-ng/messages_${HOST}"); };
        destination d_logs {
                file(
                        "/var/log/syslog-ng/logs.txt"
                        owner("rik")
                        group("root")
                        perm(0777)
                        ); };
        log { source(s_local); source(s_network); destination(d_logs); };
EOT

sudo mkdir /var/log/syslog-ng
sudo touch /var/log/syslog-ng/logs.txt

sudo systemctl start syslog-ng
sudo systemctl enable syslog-ng

