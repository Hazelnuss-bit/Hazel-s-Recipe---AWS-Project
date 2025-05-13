# 🌐 Hazel's Recipe — AWS Project 🚀

![2](https://github.com/user-attachments/assets/1422d261-ac5b-4115-b174-70f924157544)
![4](https://github.com/user-attachments/assets/cb850d10-958b-4f2f-9889-1fa49ff8d754)
![3](https://github.com/user-attachments/assets/fead9619-dc80-40e6-85e0-ebf94451c2ab)
![7](https://github.com/user-attachments/assets/8f5708c7-6b50-44f8-b013-c19046dc506c)




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

## 🗺️ Basic WordPress Deployment Architecture

![diagram](https://github.com/user-attachments/assets/7bdb9167-65c0-4121-9a53-ca863faedb92)

This architecture was created as part of a learning project and represents a simple, single-instance WordPress deployment on AWS. It is intended for educational purposes and helps demonstrate how basic AWS services work together to host a web application. The design includes:

- A custom VPC (`10.0.0.0/16`) for isolated networking.
- One public subnet (`10.0.0.0/28`) within a single Availability Zone.
- An EC2 instance configured with a LAMP stack and WordPress.
- A security group to allow HTTP and SSH access.
- An internet gateway and route table to enable external connectivity.
- Public access to the WordPress site via the EC2 instance’s IP address.

This setup is ideal for gaining hands-on experience with AWS infrastructure, Terraform automation, and WordPress deployment basics.

# 📘 How to Use

### 🔧 Requirements

- Terraform 1.0 or higher – for managing infrastructure as code
- AWS CLI – installed and configured on your machine
- An AWS account with permissions to create resources like EC2, VPC, subnets, and security groups

### 🚀 Steps to Deploy

1. **Clone the repository to your local machine**:
   ```bash
   git clone https://github.com/yourusername/aws-wordpress-terraform.git
   cd aws-wordpress-terraform
   ```

2. **Set up your AWS credentials, either by**:
   - Configuring ~/.aws/credentials, or
   - Exporting environment variables:
     ```bash
     export AWS_ACCESS_KEY_ID=your_key
     export AWS_SECRET_ACCESS_KEY=your_secret
     ```

3. **(Optional)** Edit `variables.tf` to adjust `key_name`, `subnet_id`, or `security_group_id` if not using `terraform.tfvars`.

4. **Initialize Terraform**:
   ```bash
   terraform init
   ```

5. **Apply the Terraform plan**:
   ```bash
   terraform apply
   ```

6. **Access WordPress**:
   - Get the **public IP** of your EC2 instance from the output
   - Open it in your browser to complete the WordPress setup
