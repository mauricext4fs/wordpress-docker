#!/bin/bash
if [[ $SSMTP_TO ]] && [[ $SSMTP_USER ]] && [[ $SSMTP_PASS ]]; then

# set reasonable defaults

SSMTP_TLS=${SSMTP_TLS:-YES}
SSMTP_SERVER=${SSMTP_SERVER:-smtp.gmail.com}
SSMTP_PORT=${SSMTP_PORT:-587}
SSMTP_HOSTNAME=${SSMTP_HOSTNAME:-localhost}
SSMTP_FROM=${SSMTP_FROM:-USERNAME@HOSTNAME}

# root=$SSMTP_TO
cat << EOF > ssmtp.conf
mailhub=$SSMTP_SERVER:$SSMTP_PORT
AuthUser=$SSMTP_USER
AuthPass=$SSMTP_PASS
UseSTARTTLS=$SSMTP_TLS
hostname=$SSMTP_HOSTNAME
FromLineOverride=YES
EOF
