#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
#sudo systemctl status docker
sudo usermod -aG docker ec2-user
sudo docker run --name mysql-cap -e MYSQL_ROOT_PASSWORD=${var.docker_mysql} -d -p 3306:3306 mysql:5.7
mysql -h ${outputs.rds_endpoint} -P 3306 -u ${var.master_user} -p ${var.master_password}