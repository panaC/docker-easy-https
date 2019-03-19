#!/bin/bash

trap "exit" SIGHUP SIGINT SIGTERM

if [ -z "$DOMAINS" ] ; then
  echo "No domains set, please fill -e 'DOMAINS=example.com www.example.com'"
  exit 1
fi

if [ -z "$EMAIL" ] ; then
  echo "No email set, please fill -e 'EMAIL=your@email.tld'"
  exit 1
fi

DOMAINS=(${DOMAINS})
CERTBOT_DOMAINS=("${DOMAINS[*]/#/--domain }")

mkdir /var/www
mkdir /var/www/letsencrypt

certbot certonly --webroot --agree-tos --noninteractive --text --expand \
      --email ${EMAIL} \
      --webroot-path /var/www/letsencrypt \
      ${CERTBOT_DOMAINS} && \
certbot renew --dry-run &
nginx -g "daemon off;"