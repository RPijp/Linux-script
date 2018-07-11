#!/bin/sh
#This is the script for the master server

#instal Salt

apt-get update
apt-get upgrade -y

wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add

echo deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main >> /etc/apt/sources.list

sudo apt-get update
sudo apt-get install salt-master -y

sudo apt-get upgrade -y

echo interface: 10.0.0.5 >> /etc/salt/master

sudo systemctl restart salt-master

salt-key

salt-key -Ay

sleep 2

salt-master

#instal monitoring in de form van Cacti

apt-get install snmpd snmp apache2 libapache2-mod-php5 \
php5-cli php5-snmp

apt-get install cacti -y

apt-get install snmp snmpd -y


######
##Instal Cacti on minion##

salt '*' cmd.run 'sudo apt install snmpd snmp apache2 libapache2-mod-php5 \
php5-cli php5-snmp -y'

#instal logs in de vorm van Syslog-NG Master

sudo apt install syslog-ng -y

cat <<EOT >> /etc/syslog-ng/syslog-ng.conf
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

######
##Instal Syslog-NG Minion on minion##

salt '*' cmd.run 'sudo apt install syslog-ng -y'

salt '*' cmd.run 'cat <<EOT >> /etc/syslog-ng/syslog-ng.conf
@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
source s_local { system(); internal(); };
destination d_syslog_tcp {
        syslog("10.0.0.5" transport("tcp") port(514)); };
log { source(s_local);destination(d_syslog_tcp); };
EOT'

salt '*' cmd.run 'sudo systemctl start syslog-ng'
salt '*' cmd.run 'sudo systemctl enable syslog-ng'


#Install wordpress

wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

sudo rsync -av wordpress/* /var/www/html/

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
