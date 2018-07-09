#!/bin/sh
#This is the script for the minion server

#Instal salt minion

apt-get update
apt-get upgrade -y

wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add –

echo deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main >> /etc/apt/sources.list.d/saltstack.list

sudo apt-get update
sudo apt-get install salt-minion -y

sudo apt-get upgrade -y

echo master: 10.0.61.6 >> /etc/salt/minion

sudo systemctl restart salt-minion

salt-minion

