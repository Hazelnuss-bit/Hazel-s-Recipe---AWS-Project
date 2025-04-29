#!/bin/bash

# Update system packages
sudo yum update -y

# Install Apache (httpd)
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Install Amazon Linux Extras and PHP 8.0
sudo amazon-linux-extras enable php8.0
sudo yum clean metadata
sudo yum install php php-cli php-pdo php-mysqlnd php-fpm php-xml php-mbstring wget unzip -y

# Restart Apache to load PHP modules
sudo systemctl restart httpd

# Install MariaDB
sudo yum install mariadb105-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Set up MariaDB (manual root password setup skipped for automation)

# Create WordPress database and user
mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE wordpress;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

# Move WordPress files to Apache's root directory
sudo mv wordpress/* /var/www/html/

# Set correct ownership and permissions
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configure WordPress database settings
cd /var/www/html
sudo cp wp-config-sample.php wp-config.php

sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wp_user/" wp-config.php
sudo sed -i "s/password_here/admin123/" wp-config.php

# Set wp-config.php permissions
sudo chmod 644 wp-config.php

# Restart Apache again
sudo systemctl restart httpd

echo "✅ WordPress installation is complete!"
sudo yum install php php-mysqlnd php-fpm php-xml php-mbstring -y
sudo systemctl restart httpd

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

# Move WordPress files to the Apache web directory
sudo mv wordpress/* /var/www/html/

# Set correct ownership and permissions
sudo chown -R apache:apache /var/www/html/*
sudo chmod -R 755 /var/www/html/*

# Create wp-config.php file
cd /var/www/html
sudo cp wp-config-sample.php wp-config.php

# Automate wp-config.php with database credentials
sudo sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', 'wordpress' );/" wp-config.php
sudo sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', 'wp_user' );/" wp-config.php
sudo sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', 'admin123' );/" wp-config.php

# Set permissions for wp-config.php
sudo chmod 644 wp-config.php

# Restart Apache to ensure everything is loaded
sudo systemctl restart httpd

echo "WordPress installation is complete!" # just print a message