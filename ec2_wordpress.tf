# EC2 Instance
resource "aws_instance" "wordpress" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pub1-wordpress.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name      = var.key_name

tags = {
    Name = "WordPress-EC2"
  }
}
