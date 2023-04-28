#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
#sudo systemctl status docker
sudo usermod -aG docker ec2-user
sudo docker run -it --rm mysql mysql -h ${outputs.rds_endpoint} -u ${var.master_user} -p${var.master_password} -D ${var.database_name}