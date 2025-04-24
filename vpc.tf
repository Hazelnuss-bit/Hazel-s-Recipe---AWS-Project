# Creating VPC
resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_subnet" "pub1-wordpress" {
  cidr_block        = "10.0.0.0/28"
  availability_zone = "us-west-2a"
  vpc_id            = aws_vpc.wordpress-vpc.id
  
  tags = {
    Name = "pub1-wordpress"
  }
}