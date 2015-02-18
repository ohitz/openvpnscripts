#!/bin/bash

PROGDIR=`dirname $0`
TEMPLATE=$PROGDIR/client-template.txt

EASYRSA=/etc/openvpn/easy-rsa/

CLIENT=$1

if [ -z "$CLIENT" ]; then
  echo "Usage: $0 CLIENT > client.ovpn"
  exit 1
fi

CACRT=$EASYRSA/keys/ca.crt
CLIENTCRT=$EASYRSA/keys/$CLIENT.crt
CLIENTKEY=$EASYRSA/keys/$CLIENT.key

if [ ! -r "$CACRT" ]; then
  echo "CA cert $CACRT not found or not readable."
  exit
fi
if [ ! -r "$CLIENTCRT" ]; then
  echo "Client cert $CLIENTCRT not found or not readable."
  exit
fi
if [ ! -r "$CLIENTKEY" ]; then
  echo "Client key $CLIENTKEY not found or not readable."
  exit
fi

cat $TEMPLATE
echo "<ca>"
cat $CACRT
echo "</ca>"
echo "<cert>"
cat $CLIENTCRT
echo "</cert>"
echo "<key>"
cat $CLIENTKEY
echo "</key>"

