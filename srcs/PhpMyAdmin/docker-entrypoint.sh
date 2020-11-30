#!/bin/sh
rc-update add php-fpm7 default
rc boot
rc-service php-fpm7 start
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
sleep infinity & wait
bash