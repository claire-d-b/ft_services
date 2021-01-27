#!/bin/sh

until grafana-cli
do
  echo ""
done

grafana-cli --config=/etc/grafana.ini --homepath=/usr/share/grafana admin reset-admin-password clde-ber@student.42.fr