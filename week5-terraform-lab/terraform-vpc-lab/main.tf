 provider "aws" {
    region = "us-east-1"
  }
  resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "week5-vpc"
    }
  }
  resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "public-subnet"
    }
  }
  resource "aws_subnet" "private" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.2.0/24"

    availability_zone = "us-east-1a"

    tags = {
      Name = "private-subnet"
    }
  }
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "week5-igw"
    }
  }
   resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "public-rt"
    }
  }
   resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  }
  resource "aws_security_group" "ssh" {
    name        = "allow-ssh"
    description = "Allow SSH from my IP"
    vpc_id      = aws_vpc.main.id

    ingress {
      description = "SSH from my IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["47.156.3.51/32"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "allow-ssh"
    }
  }
  data "aws_ssm_parameter" "al2023" {
    name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  }

  resource "aws_instance" "web" {
    ami                    = data.aws_ssm_parameter.al2023.value
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.ssh.id]
    key_name               = "rodrigo-key"

    tags = {
      Name = "week5-ec2"
    }
  }