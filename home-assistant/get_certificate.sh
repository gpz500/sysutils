#!/bin/bash

DOMAIN_NAME=xxx.example.com
DEST_DIR=/home/homeassistant

scp "root@monsterino.fritz.box:/etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem" "$DEST_DIR/$DOMAIN_NAME/fullchain.pem"
scp "root@monsterino.fritz.box:/etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem" "$DEST_DIR/$DOMAIN_NAME/privkey.pem"
chmod 0644 "$DEST_DIR/$DOMAIN_NAME/fullchain.pem"
chmod 0640 "$DEST_DIR/$DOMAIN_NAME/privkey.pem"
sudo systemctl reload caddy.service
