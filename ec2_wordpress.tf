# EC2 Instance
resource "aws_instance" "wordpress" {
  ami = "ami-05572e392e80aee89" # Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pub1-wordpress.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name      = var.key_name

  user_data = file("userdata.sh")


  tags = {
    Name = "WordPress-EC2"
  }
}
