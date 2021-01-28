#!/bin/sh
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
sed -i 's+;protocol = http+protocol = http+g' etc/grafana.ini
sed -i 's+;http_port = 3000+http_port = 3000+g' etc/grafana.ini
sed -i 's+;domain = localhost+domain = 192.168.49.3+g' etc/grafana.ini
sed -i 's+;root_url = %(protocol)s://%(domain)s:%(http_port)s/+root_url = %(protocol)s://%(domain)s:%(http_port)s/+g' etc/grafana.ini
sed -i 's+;type = sqlite3+type = sqlite3+g' etc/grafana.ini
sed -i 's+;host = 127.0.0.1:3306+host = 127.0.0.1:8086+g' etc/grafana.ini
sed -i 's+;name = grafana+name = influxdb+g' etc/grafana.ini
sed -i 's+;user = root+user = grafana+g' etc/grafana.ini
sed -i 's+;password =+password =+g' etc/grafana.ini
sed -i 's+;admin_user = admin+admin_user = admin+g' etc/grafana.ini
sed -i 's+;admin_password = admin+admin_password = clde-ber@student.42.fr+g' etc/grafana.ini
sed -i 's+;secret_key+secret_key+g' etc/grafana.ini
nohup /usr/sbin/grafana-server --config=/etc/grafana.ini --homepath=/usr/share/grafana 0</dev/null &
sleep infinity & wait
bash