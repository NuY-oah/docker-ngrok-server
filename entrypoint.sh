#!/bin/sh -e

NGROK_HOME=/usr/local/ngrok

cd $NGROK_HOME

# init ngrok server if build.info is not exist.
if [ ! -f "build.info" ]; then
  echo "init ngrok server!"
  DOMAIN=$1
  HTTP_PORT=$2
  HTTPS_PORT=$3
  TUNNEL_PORT=$4

  make release-server

  # save build info to file
  echo "$DOMAIN" >> build.info
  echo "$HTTP_PORT" >> build.info
  echo "$HTTPS_PORT" >> build.info
  echo "$TUNNEL_PORT" >> build.info
fi

# start ngrok server
DOMAIN=$(sed -n "1p" build.info)
HTTP_PORT=$(sed -n "2p" build.info)
HTTPS_PORT=$(sed -n "3p" build.info)
TUNNEL_PORT=$(sed -n "4p" build.info)

./bin/ngrokd -domain="$DOMAIN" -httpAddr=":$HTTP_PORT" -httpsAddr=":$HTTPS_PORT" -tunnelAddr=":$TUNNEL_PORT"
