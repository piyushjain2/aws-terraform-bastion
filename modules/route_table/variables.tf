variable "vpc_id" {
  description = "VPC Id"
}

variable "internet_gateway_id" {
  description = "Internet Gateway Id"
}

variable "subnet_ids" {
  type = "list"
  description = "Subnet ids"
}