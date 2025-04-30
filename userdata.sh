#!/bin/bash

# Update system packages
sudo yum update -y

# Install httpd (Apache), start and enable it
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Install MariaDB and start it
sudo yum install mariadb105-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Install expect for automating mysql_secure_installation
sudo yum install expect -y

# Automate mysql_secure_installation
expect <<EOF
spawn mysql_secure_installation
expect "Enter current password for root (enter for none):"
send "\n"
expect "Set root password? [Y/n]"
send "Y\n"
expect "New password:"
send "root\n"
expect "Re-enter new password:"
send "root\n"
expect "Remove anonymous users? [Y/n]"
send "Y\n"
expect "Disallow root login remotely? [Y/n]"
send "Y\n"
expect "Remove test database and access to it? [Y/n]"
send "Y\n"
expect "Reload privilege tables now? [Y/n]"
send "Y\n"
expect eof
EOF

# Create WordPress DB and user
mysql -u root -proot <<MYSQL_SCRIPT
CREATE DATABASE wordpress;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Install PHP and necessary modules
sudo yum install php php-mysqlnd php-fpm php-xml php-mbstring -y

# Ensure Apache serves PHP by default
sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/' /etc/httpd/conf/httpd.conf

# Restart Apache to load PHP modules
sudo systemctl restart httpd

# Download and unpack WordPress
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

# Move WordPress to Apache root
sudo mv wordpress/* /var/www/html/

# Set permissions
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configure wp-config.php
cd /var/www/html
sudo cp wp-config-sample.php wp-config.php
sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wp_user/" wp-config.php
sudo sed -i "s/password_here/admin123/" wp-config.php

# Set safe permissions
sudo chmod 644 wp-config.php

# Final restart
sudo systemctl restart httpd

echo "WordPress installation complete!"
