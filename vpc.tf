resource "aws_vpc" "nf_vpc" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "nf_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.nf_vpc.id
  cidr_block        = "10.0.1.0/26"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "nf_public"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.nf_vpc.id
  cidr_block        = "10.0.2.0/26"
  availability_zone = "us-west-2a"

  tags = {
    Name = "nf_private_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.nf_vpc.id
  cidr_block        = "10.0.3.0/26"
  availability_zone = "us-west-2b"

  tags = {
    Name = "nf_private_2"
  }
}

resource "aws_subnet" "db_subnet_1" {
  vpc_id            = aws_vpc.nf_vpc.id
  cidr_block        = "10.0.4.0/26"
  availability_zone = "us-west-2a"

  tags = {
    Name = "db_subnet_1"
  }
}

resource "aws_subnet" "db_subnet_2" {
  vpc_id            = aws_vpc.nf_vpc.id
  cidr_block        = "10.0.5.0/26"
  availability_zone = "us-west-2b"

  tags = {
    Name = "db_subnet_2"
  }
}

resource "aws_db_subnet_group" "db_net" {
  name        = "db_net_group"
  subnet_ids  = [aws_subnet.db_subnet_1.id, aws_subnet.db_subnet_2.id]

  tags = {
    Name = "nf_aurora_db"
  }
}