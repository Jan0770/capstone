resource "aws_vpc" "vpc" {
  cidr_block            = var.vpc_cidr
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "capVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "host_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.host_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  # mapping public ip for testing as of now
  map_public_ip_on_launch = true

  tags = {
    Name = "host_subnet_1"
  }
}

resource "aws_subnet" "host_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.host_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  # same as above
  map_public_ip_on_launch = true
  tags = {
    Name = "host_subnet_2"
  }
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.database_subnets_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "db_subnet_1"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.database_subnets_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "db_subnet_2"
  }
}

resource "aws_db_subnet_group" "db_net" {
  name        = "db_net_group"
  subnet_ids  = [aws_subnet.db_subnet_1.id, aws_subnet.db_subnet_2.id]

  tags = {
    Name = "db_subnet_group"
  }
}