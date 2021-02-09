#!/bin/sh
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
cp srcs/nginx.conf /usr/share/nginx/http-default_server.conf
cp srcs/nginx.conf etc/nginx/http.d/default.conf
rc-update add nginx default
openrc boot
rc-update add php-fpm7 default
openrc boot
rc-update add telegraf default
openrc boot
rc-service telegraf start
rc-service nginx start
rc-service php-fpm7 start
nohup ./install_wp.sh 0</dev/null &
sleep infinity & wait
bash