variable "region" {
  description = "AWS region"
  default = "us-east-2"
}

variable "ami" {
  description = "AWS AMI"
  default = "ami-0603cbe34fd08cb81"
}

variable "aws_access_key" {
  description = "AWS Access key"
}

variable "aws_secret_key" {
  description = "AWS Secret key"
}

variable "key_name_prefix" {
  description = "EC2 Access key"
  default = "terraform"
}