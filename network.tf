# VPC
resource "aws_vpc" "alb_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ALB-VPC"
  }
}

# Subnet 1
resource "aws_subnet" "alb_subnet_1" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ALB-Subnet-1"
  }
}

# Subnet 2
resource "aws_subnet" "alb_subnet_2" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ALB-Subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "alb_igw" {
  vpc_id = aws_vpc.alb_vpc.id

  tags = {
    Name = "ALB-IGW"
  }
}

# Route Table
resource "aws_route_table" "alb_route_table" {
  vpc_id = aws_vpc.alb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.alb_igw.id
  }

  tags = {
    Name = "ALB-Route-Table"
  }
}

# Route Table Associations
resource "aws_route_table_association" "alb_rta_1" {
  subnet_id      = aws_subnet.alb_subnet_1.id
  route_table_id = aws_route_table.alb_route_table.id
}

resource "aws_route_table_association" "alb_rta_2" {
  subnet_id      = aws_subnet.alb_subnet_2.id
  route_table_id = aws_route_table.alb_route_table.id
}
