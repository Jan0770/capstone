resource "aws_instance" "ec2_instance" {
  ami                     = var.ami
  instance_type           = "t3.micro"
  subnet_id               = aws_subnet.public_subnet_1.id
  vpc_security_group_ids  = [aws_security_group.ssh_ingress.id]
  key_name                = var.ssh_key
  associate_public_ip_address = true
  user_data = "${file("dockerWPuserdata.sh")}" 

  tags = {
    Name = "WP_EC2"
  }
}
