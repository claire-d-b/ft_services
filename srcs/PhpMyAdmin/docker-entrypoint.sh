#!/bin/sh
/etc/nginx/sites-available/default
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
rc-update add php-fpm7 default
openrc boot
rc-service php-fpm7 start
rc-update add nginx default
openrc boot
rc-service nginx start
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
sleep infinity & wait
bash