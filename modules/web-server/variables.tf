variable "environment_name" {
  description = "environment identifier"
}

variable "vpc_id" {
  description = "the id for the vpc in which the security group should be created"
}

variable "subnet" {
  description = "subnet in which to place the instance"
}

variable "server_http_port" {
  description = "port where the http server is running"
  default     = 80
}

variable "ami_id" {}

variable "instance_size" {
  description = "ec2 instance size"
  default     = "t2.micro"
}

variable "tags" {
  description = "A map of tags to add to all resourcess"
  type        = map(string)
  default     = {}
}
