#!/bin/sh
# Your commands go under this line

#instal monitoring in de form van Cacti


apt-get update
apt-get upgrade

apt-get install snmpd snmp mysql-server apache2 libapache2-mod-php5 \
php5-mysql php5-cli php5-snmp

apt-get install cacti -y

apt-get install snmp snmpd -y

apt-get install cacti-spine -y


#instal logs in de vorm van Syslog-NG

sudo apt install syslog-ng -y

