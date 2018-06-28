#!/bin/sh
#This is the script for the master server

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

#instal logs in de vorm van Syslog-NG Master

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


#instal saltstack master

wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add –

echo “deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main” >> /etc/apt/sources.list.d/saltstack.list

sed -I ‘s/deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main/ deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main/g’ /etc/salt/master

sudo apt-get update
sudo apt-get install salt-master -y
sudo apt-get install salt-ssh -y
sudo apt-get install salt-syndic -y
sudo apt-get install salt-api -y
sudo apt-get install salt-cloud -y

sudo apt-get upgrade -y

sudo systemctl restart salt-minion

sed -I ‘s/#interface: 0.0.0.0 /interface: 10.0.61.6/g’ /etc/salt/master

salt-master
