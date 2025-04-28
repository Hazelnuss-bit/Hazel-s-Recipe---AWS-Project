#!/bin/bash
# Update all packages
yum update -y

# Install Apache
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Install MariaDB (MySQL server)
yum install -y mariadb-server
systemctl start mariadb
systemctl enable mariadb

# Enable PHP 8.0 from Amazon Linux Extras
amazon-linux-extras enable php8.0
yum clean metadata
yum install -y php php-mysqlnd php-fpm php-cli php-json php-common php-mbstring php-xml

# Install wget and unzip (needed for WordPress download)
yum install -y wget unzip

# Set up MariaDB database and user for WordPress
mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'strongpassword';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Download and set up WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Set correct permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure WordPress to connect to the database
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/wordpressuser/" wp-config.php
sed -i "s/password_here/strongpassword/" wp-config.php

# Restart Apache
systemctl restart httpd
