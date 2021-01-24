#!bin/sh

#touch toto.txt

until mysql
do
  echo ""
done


#echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
#echo "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root --skip-password
#echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
#echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
#echo "DROP DATABASE test" | mysql -u root --skip-password
#echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
#echo "use wordpress; source wordpress.sql;" | mysql

#echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('');" | mysql --port=3306 --user=root
#echo "FLUSH PRIVILEGES;" | mysql --port=3306 --user=root
echo "SET old_passwords=0;" | mysql --port=3306 --user=root
echo "CREATE DATABASE wordpress;" | mysql mysql --port=3306 --user=root
echo "USE wordpress;" | mysql --port=3306 --user=root
echo "CREATE USER 'root'@'%' IDENTIFIED BY '';" | mysql --port=3306 --user=root
echo "GRANT ALL ON wordpress.* TO 'root'@'%';" | mysql --port=3306 --user=root
#echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'%' WITH GRANT OPTION;" | mysql --port=3306 #--host=192.168.49.3 --user=root
#echo "UPDATE mysql.user SET plugin='mysql_native_password' where user='root';" | mysql --port=3306 #--host=192.168.49.3 --user=root
echo "FLUSH PRIVILEGES;" | mysql --port=3306 --user=root
echo "exit" | mysql --port=3306 --user=root
