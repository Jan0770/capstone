resource "aws_instance" "ec2_instance" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = aws_subnet.public_subnet.id
  vpc_security_group_ids  = [aws_security_group.bastion_security.id]
  key_name                = var.ssh_key
  associate_public_ip_address = true
  user_data = base64encode(file("bastion.sh"))

  tags = {
    Name = "Bastion"
  }
}
