#!/bin/sh
sleep 20
echo "CREATE DATABASE influxdb;" | influx -username grafana
echo "CREATE USER grafana WITH PASSWORD '' WITH ALL PRIVILEGES;" | influx -username grafana