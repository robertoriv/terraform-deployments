variable "environment_name" {
  description = "environment name"
}

variable "region" {
  description = "region"
}

variable "vpc_cidr" {
  description = "vpc cidr"
}

variable "availability_zones" {
  description = "availability zones"
}

variable "public_subnets" {
  description = "public subnets"
}

variable "private_subnets" {
  description = "private subnets"
}

variable "server_http_port" {
  description = "port where the http server is running"
  default     = 80
}

variable "security_group_name" {
  description = "security group name"
}

variable "ami_id" {}

variable "instance_size" {
  description = "ec2 instance size"
  default     = "t2.micro"
}
