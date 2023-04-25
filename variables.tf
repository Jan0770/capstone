variable "tags" {
  description = "creates tags when spawning resources"
  type        = map(any)
  default = {
    app         = "wordpress",
    environment = "dev"
  }
}

variable "ami" {
  description = "us-west-2 Amazon Linux 2"
  default     = "ami-009c5f630e96948cb"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t3.micro"
}

variable "prefix" {
  description = "Prefix can be used for creating resoures"
  default     = "wordpress"
}

variable "environment" {
  description = "Name of the application environment. e.g. dev, prod, test, staging"
  default     = "dev"
}

variable "availability_zones" {
    description = "AZs for this project"
    default = ["us-west-2a", "us-west-2b"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/26", "10.0.2.0/26"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.3.0/26", "10.0.4.0/26"]
}

variable "database_subnets_cidrs" {
  description = "CIDR blocks for db subnets"
  default     = ["10.0.5.0/26", "10.0.6.0/24"]
}

variable "asg_instance_type" {
  description = "AutoScaling Group Instance type"
  default     = "t3.micro"
}
variable "asg_launch_template_description" {
  description = "AutoScaling Group launch template description"
  default     = "Wordpress Launch Template"
}

variable "asg_min_size" {
  description = "AutoScaling Group Min Size "
  default     = 1
}

variable "asg_max_size" {
  description = "AutoScaling Group Max Size "
  default     = 3
}

variable "asg_desired_capacity" {
  description = "AutoScaling Group Desired Capacity"
  default     = 1
}

# Includes 2 DB engines, choose depending on requirements
# MariaDB
variable "rds_engine" {
  description = "RDS engine"
  default     = "mariadb"
}

variable "rds_engine_version" {
  description = "RDS engine version"
  default     = "10.6.7"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

# AuroraDB
variable "aurora_engine" {
    description = "aurora engine"
    default     = "aurora-mysql"
  
}

variable "aurora_engine_version" {
    description = "aurora engine version"
    default     = "5.7.mysql_aurora.2.11.1"
  
}

variable "ssh_key" {
  description = "SSH Key"
  default     = "vockey"
}
