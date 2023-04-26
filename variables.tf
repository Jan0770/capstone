        # EC2 #
variable "ami" {
  description = "us-west-2 Amazon Linux 2"
  default     = "ami-0ac64ad8517166fb1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t3.micro"
}

variable "availability_zones" {
    description = "AZs for this project"
    default = ["us-west-2a", "us-west-2b"]
}

        # VPC # 
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnets"
  default     = "10.0.1.0/26"
}

variable "host_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.2.0/26", "10.0.3.0/26"]
}

variable "database_subnets_cidrs" {
  description = "CIDR blocks for db subnets"
  default     = ["10.0.4.0/26", "10.0.5.0/26"]
}

        # Autoscaling #
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
  default     = 2
}

variable "asg_max_size" {
  description = "AutoScaling Group Max Size "
  default     = 6
}

variable "asg_desired_capacity" {
  description = "AutoScaling Group Desired Capacity"
  default     = 2
}

        # AuroraDB #
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

        # Database #
variable "database_name" {
  default = "capstoneDB"
}

variable "master_user" {
  default = "capstoneRoot"
}

variable "master_password" {
  default = "mustbeeightcharaters"
}