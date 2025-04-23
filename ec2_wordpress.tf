resource "aws_instance" "wordpress" {
  ami           = "ami-0440d3b780d96b29d"  # Amazon Linux 2023
  instance_type = "t2.micro"
  
  subnet_id                  = var.subnet_id
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

output "public_ip" {
  value = aws_instance.wordpress.public_ip
}
