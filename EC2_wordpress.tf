resource "aws_instance" "wordpress_server" {
  ami           = "ami-0440d3b780d96b29d"  # Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  
  # Replace these with your existing resource IDs
  subnet_id                   = var.subnet_id
  vpc_security_group_ids     = [var.security_group_id]
  key_name                   = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "WordPress-Server"
  }
}

output "instance_public_ip" {
  value = aws_instance.wordpress_server.public_ip
}
