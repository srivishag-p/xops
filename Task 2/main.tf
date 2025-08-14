provider "aws" {
  region = "us-east-1" # Change if needed
}

resource "aws_vpc" "xops_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "xops-vpc" }
}

resource "aws_subnet" "xops_subnet" {
  vpc_id                  = aws_vpc.xops_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = { Name = "xops-subnet" }
}

resource "aws_internet_gateway" "xops_igw" {
  vpc_id = aws_vpc.xops_vpc.id
  tags   = { Name = "xops-igw" }
}

resource "aws_route_table" "xops_route_table" {
  vpc_id = aws_vpc.xops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.xops_igw.id
  }
  tags = { Name = "xops-route-table" }
}

resource "aws_route_table_association" "xops_rta" {
  subnet_id      = aws_subnet.xops_subnet.id
  route_table_id = aws_route_table.xops_route_table.id
}

resource "aws_security_group" "xops_sg" {
  name        = "xops-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.xops_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "xops_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.xops_subnet.id
  vpc_security_group_ids = [aws_security_group.xops_sg.id]
  key_name      = "xops-key" # You must create this key pair in AWS beforehand

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>Hello from XOps!</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "xops-webserver" }
}
