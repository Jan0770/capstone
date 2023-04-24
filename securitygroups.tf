resource "aws_security_group" "ssh-ingress" {
  name        = "ssh-ingress"
  description = "Allow SSH ingress"
  vpc_id      = aws_vpc.nf_vpc.id

  ingress {
    description      = "allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-ingress"
  }
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.nf_vpc.id

  ingress {
    description      = "allow web"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_security_group" "allow_ec2_aurora" {
  name        = "allow_ec2_aurora"
  description = "Allow EC2 to Aurora traffic"
  vpc_id      = aws_vpc.nf_vpc.id

  egress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_aurora_access" {
  name        = "allow_aurora_access"
  description = "Allow EC2 to aurora"
  vpc_id = aws_vpc.nf_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_ssh.id] 
  }

  tags = {
    Name = "aurora-stack-allow-aurora-MySQL"
  }
}