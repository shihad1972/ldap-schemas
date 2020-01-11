#!/bin/sh
#
# Add SSL configuration to SLAPD
#
LOCK=/etc/ldap/.$1-config
CONF=/tmp/$1.ldif

if [ -f $LOCK ]; then
  exit 0
fi

if [ ! -f $CONF ]; then
  echo "No config file $CONF!"
  exit 1
fi

/usr/bin/ldapadd -Y EXTERNAL -H ldapi:/// -f $CONF

if [ $? -eq 0 ]; then
  touch $LOCK
else
  echo "Failed to add $1 config"
  exit 1
fi
