#!/bin/sh
# start mysql server locating the pid file in another place than the default insecure /tmp.
# -D --daemonize This option causes the server to run as a traditional, forking daemon, permitting it
# to work with operating systems that use systemd for process control. 
# mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=root -D
# WITH GRANT OPTION creates a MySQL user that can edit the permissions of other users.
# set the plugin so it is no more the default sha256_password plugin - was introduced in MySQL Server 5.6, and provides
# additional security focused on password storage.
# For the new user rights to be taken into account, a flush request has to be sent.
# echo "CREATE DATABASE wordpress;" | mysql --port=13306 --host=localhost --user=root
# echo "USE wordpress;" | mysql --port=13306 --host=localhost --user=root
# echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql --port=13306 --host=localhost --user=root
# echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql --port=13306 --host=localhost --user=root
# echo "FLUSH PRIVILEGES;" | mysql --port=13306 --host=localhost --user=root
mysqld --user=root
sleep infinity & wait
bash