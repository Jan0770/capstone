#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Docker WP connected to RDS 
sudo docker run --name local-wordpress -e WORDPRESS_DB_HOST=aurora.cluster-chatrjila9rq.us-west-2.rds.amazonaws.com -e WORDPRESS_DB_USER=capstoneRoot -e WORDPRESS_DB_PASSWORD=mustbeeightcharacters -e WORDPRESS_DB_NAME=capstoneDB -d -p 80:80 wordpress
sudo docker start local-wordpress