#!/bin/sh
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
rc-update add influxdb default
rc boot
rc-service influxdb start
echo "CREATE DATABASE influxdb" | influx -username grafana -password ''
echo "CREATE USER grafana WITH PASSWORD '' WITH ALL PRIVILEGES" | influx -username grafana -password ''
echo "exit" | influx -username grafana -password ''
sleep infinity & wait
bash