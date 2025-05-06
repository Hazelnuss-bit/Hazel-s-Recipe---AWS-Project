# 🌐 Hazel's Recipe — AWS Project 🚀

📘 Project Description

Hazel's Recipe is a simple and beginner-friendly infrastructure project that deploys a basic WordPress website on AWS using Terraform. It sets up fundamental components like a VPC, public subnet, EC2 instance, security group, internet gateway, and route table. The goal is to demonstrate how to launch a minimal, functional cloud environment suitable for learning or small-scale use.

## 🏗️ Infrastructure Overview

**VPC** – A custom virtual private cloud to host your infrastructure.  
**Subnet (Public)** – A single public subnet where your EC2 instance resides.  
**Internet Gateway** – Enables internet access for your EC2 instance.  
**Route Table** – Configured to allow traffic from the subnet to the internet via the Internet Gateway.  
**Security Group** – Allows inbound access (e.g., HTTP on port 80, SSH on port 22).  
**EC2 Instance (Amazon Linux 2)** – A virtual server that hosts the WordPress website.


## 📜 User Data Script Overview

This script is executed automatically when the EC2 instance is launched. It installs and configures a full LAMP stack and WordPress CMS.

1. **System Update** – Updates all packages to the latest version for security and stability.
2. **Apache Installation** – Installs, starts, and enables the Apache web server.
3. **MariaDB Installation** – Installs MariaDB (MySQL-compatible), starts the service, and enables it on boot.
4. **Database Hardening** – Uses `expect` to automate `mysql_secure_installation` for basic security configurations.
5. **WordPress Database Setup** – Creates a new database (`wordpress`) and a user (`wp_user`) with the necessary privileges.
6. **PHP Installation** – Installs PHP and required extensions for WordPress functionality.
7. **WordPress Installation** – Downloads, extracts, and moves WordPress files into Apache's root directory.
8. **Permissions Configuration** – Sets proper file and folder permissions to ensure Apache can serve WordPress securely.
9. **Configuration File** – Modifies `wp-config.php` with appropriate database credentials.
10. **Final Setup** – Restarts Apache to ensure all services are running properly.

Once completed, WordPress is ready to be accessed via the EC2 instance’s public IP address.
