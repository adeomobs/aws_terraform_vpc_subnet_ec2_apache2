resource "aws_vpc" "bincom_iac_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.env_name}"
  }
}

resource "aws_subnet" "bincom_iac_public_subnet" {
  vpc_id            = aws_vpc.bincom_iac_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name} Public Subnet"
  }
}

resource "aws_subnet" "bincom_iac_private_subnet" {
  vpc_id            = aws_vpc.bincom_iac_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.env_name} Private Subnet"
  }
}

resource "aws_internet_gateway" "bincom_iac_ig" {
  vpc_id = aws_vpc.bincom_iac_vpc.id

  tags = {
    Name = "${var.env_name} Internet Gateway"
  }
}

resource "aws_route_table" "bincom_iac_public_rt" {
  vpc_id = aws_vpc.bincom_iac_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bincom_iac_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.bincom_iac_ig.id
  }

  tags = {
    Name = "${var.env_name} Public Route Table"
  }
}

resource "aws_route_table_association" "bincom_iac_public_1_rt_a" {
  subnet_id      = aws_subnet.bincom_iac_public_subnet.id
  route_table_id = aws_route_table.bincom_iac_public_rt.id
}


resource "aws_security_group" "bincom_iac_web_sg" {
  name   = "${var.env_name} HTTP and SSH"
  vpc_id = aws_vpc.bincom_iac_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "bincom_iac_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  tenancy       = "default"


  subnet_id = aws_subnet.bincom_iac_public_subnet.id
  vpc_security_group_ids = [
    aws_security_group.bincom_iac_web_sg.id
  ]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  echo "Start Apache2"
  sudo service apache2 start
  EOF

  tags = {
    Name        = "${var.env_name} Apache 2"
    Environment = "Bincom IAC"
    OS          = "UBUNTU"
  }
}