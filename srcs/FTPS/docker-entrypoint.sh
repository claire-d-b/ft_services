#!/bin/sh
rc-update add vsftpd default
openrc boot
rc-service vsftpd start
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
sleep infinity & wait
bash