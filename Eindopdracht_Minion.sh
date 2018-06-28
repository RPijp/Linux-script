#!/bin/sh
#This is the script for the minion server

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
source s_local { system(); internal(); };
destination d_syslog_tcp {
        syslog("10.0.61.6" transport("tcp") port(514)); };
log { source(s_local);destination(d_syslog_tcp); };
EOT

sudo systemctl start syslog-ng
sudo systemctl enable syslog-ng
