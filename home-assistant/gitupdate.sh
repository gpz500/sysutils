#!/bin/bash

DEFAULT_MSG="Minor Update"

cd /home/homeassistant/.homeassistant
source /srv/homeassistant/bin/activate
hass --script check_config

git add .
git status
echo -n "Enter the Description for the Change: [${DEFAULT_MSG}] "
read CHANGE_MSG
if [ -z "$CHANGE_MSG" ]; then
    CHANGE_MSG="$DEFAULT_MSG"
fi
git commit -m "${CHANGE_MSG}"
git push origin master

exit
