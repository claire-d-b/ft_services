#!/bin/sh
until influx
do
  echo ""
done
echo "CREATE DATABASE influxdb;" | influx -username grafana
echo "CREATE USER grafana WITH PASSWORD '' WITH ALL PRIVILEGES;" | influx -username grafana