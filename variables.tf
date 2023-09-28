variable "availability_zone" {
  description = "Availability zone for subnets"
  default     = ""
  type        = string
}

variable "ami_id" {
  description = "ami for ec2 instance"
  default     = "ami-053b0d53c279acc90"
  type        = string
}


variable "instance_type" {
  description = "instance type for ec2 instance"
  default     = "t2.micro"
  type        = string
}

variable "key_pair_name" {
  description = "key pair ot login instance"
  default     = "apache2-webserver-key-pair"
  type        = string
}

variable "security_group_name" {
  description = "security group for instance"
  type        = string
  default     = "openproject_sg"
}


variable "env_name" {
  description = "Name of Environment"
  default     = "IAC Infrastructure"
}

variable "region"{
  type = string
  description="Configuration Region"
  default=""
}

variable "vpc_cidr_block"{
  type= string
  description = "cidr block for vpc"
  default = "10.0.0.0/16"
}
