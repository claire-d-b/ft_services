#!/bin/sh
rc-update add php-fpm7 default
rc-update add nginx default
rc-service php-fpm7 start
nginx -g 'pid /tmp/nginx.pid; daemon off;'
