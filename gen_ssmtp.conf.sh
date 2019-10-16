#!/bin/bash

echo
echo
echo "Let's configure sending Email with Wordpress"
echo 
echo 

read -p "Mail server Hostname (gmail smtp.gmail.com) : "
SSMTP_SERVER=$REPLY
read -p "Mail Server port (gmail 587) : "
SSMTP_PORT=$REPLY
read -p "Username : "
SSMTP_USER=$REPLY
read -sp "Pass : "
SSMTP_PASS=$REPLY
echo " "
read -p "Tls? (YES or NO) : "
SSMTP_TLS=$REPLY
SSMTP_HOSTNAME=`curl ifconfig.co`

cat <<EOF >.ssmtp.conf
mailhub=$SSMTP_SERVER:$SSMTP_PORT
AuthUser=$SSMTP_USER
AuthPass=$SSMTP_PASS
UseSTARTTLS=$SSMTP_TLS
hostname=$SSMTP_HOSTNAME
FromLineOverride=YES
EOF
