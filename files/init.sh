#!/bin/bash

/usr/local/bin/generate-CA.sh ${FQDN}
/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
