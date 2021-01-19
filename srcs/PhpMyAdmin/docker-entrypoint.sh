#!/bin/sh
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/http.d/*.conf && cp /etc/nginx/sites-enabled/default /etc/nginx/http.d/default.conf
#sed -i 's+include :w²/etc/nginx/http.d/*.conf+include /etc/nginx/sites-enabled/default+g' /etc/nginx/nginx.conf
rc-update add php-fpm7 default
openrc boot
rc-update add nginx default
openrc boot
rc-service nginx start
rc-service php-fpm7 start
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
sleep infinity & wait
bash