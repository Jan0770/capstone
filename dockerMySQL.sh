#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Docker WP connected to RDS 
sudo docker run --name local-wordpress -e WORDPRESS_DB_HOST=${rds_endpoint} -e WORDPRESS_DB_USER=${db_user} -e WORDPRESS_DB_PASSWORD=${db_password} -e WORDPRESS_DB_NAME=${database_name} -d -p 80:80 wordpress
sudo docker start local-wordpress