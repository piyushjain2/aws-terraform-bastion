variable "subnet_ids" {
  type = "list"
  description = "Subnet ids"
}

variable "aws_key_name" {
  description = "AWS key name"
}

variable "ami" {
  description = "AWS AMI"
}

variable "allow_ec2_access" {
  description = "Allow EC2 ssh security group"
}

variable "bastion_host_access" {
  description = "Allow Bastion EC2 ssh security group"
}