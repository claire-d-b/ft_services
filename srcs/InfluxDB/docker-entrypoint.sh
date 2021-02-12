#!/bin/sh
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
#rc-update add telegraf default
##openrc boot
#rc-service telegraf start
nohup telegraf --config /etc/telegraf.conf 0</dev/random &
nohup influxd 0</dev/null &
./create_db.sh
sleep infinity & wait