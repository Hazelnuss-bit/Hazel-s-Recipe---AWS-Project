#!/bin/bash

DBName="${DBName}"
DBUser="${DBUser}"
DBPassword="${DBPassword}"
DBHost="${DBHost}"
DBRootPassword="${DBRootPassword}"

# Update system
sudo yum update -y

# Install Apache Web Server
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install PHP and dependencies
sudo amazon-linux-extras enable php8.0
sudo yum clean metadata
sudo yum install -y php php-cli php-pdo php-mysqlnd php-fpm php-xml php-mbstring wget unzip

# Install MariaDB server
sudo yum install -y mariadb105-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Create WordPress database and user
sudo mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $DBName;
CREATE USER IF NOT EXISTS '$DBUser'@'localhost' IDENTIFIED BY '$DBPassword';
GRANT ALL PRIVILEGES ON $DBName.* TO '$DBUser'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Download and install WordPress
sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
sudo tar -zxvf latest.tar.gz
sudo cp -rvf wordpress/* .
sudo rm -R wordpress
sudo rm latest.tar.gz

# Configure WordPress
sudo cp ./wp-config-sample.php ./wp-config.php 
sudo sed -i "s/'database_name_here'/'$DBName'/g" wp-config.php
sudo sed -i "s/'username_here'/'$DBUser'/g" wp-config.php
sudo sed -i "s/'password_here'/'$DBPassword'/g" wp-config.php
sudo sed -i "s/'localhost'/'$DBHost'/g" wp-config.php

# Set correct permissions
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www/
sudo chmod 2775 /var/www/
sudo find /var/www/ -type d -exec chmod 2775 {} \;
sudo find /var/www/ -type f -exec chmod 0664 {} \;

# Restart Apache
sudo systemctl restart httpd

echo "✅ WordPress installation and configuration complete!"