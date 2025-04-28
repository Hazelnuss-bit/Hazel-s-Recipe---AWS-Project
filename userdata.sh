#!/bin/bash
yum update -y
yum install -y httpd mariadb-server php php-mysqlnd wget tar unzip

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Start and enable MariaDB
systemctl start mariadb
systemctl enable mariadb

# Setup MySQL database and user
mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'strongpassword';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Install WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure WordPress to connect to DB
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/wordpressuser/" wp-config.php
sed -i "s/password_here/strongpassword/" wp-config.php

# Restart Apache
systemctl restart httpd
