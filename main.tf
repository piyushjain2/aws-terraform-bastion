provider "aws" {
  region     = "${var.region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

module "vpc" {
  source = "./modules/vpc"
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = "${module.vpc.id}"
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = "${module.vpc.id}"
  region = "${var.region}"
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id = "${module.vpc.id}"
  internet_gateway_id = "${module.internet_gateway.id}"
  subnet_ids = "${module.subnets.subnet_ids}"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = "${module.vpc.id}"
}

module ssh_key_aws {
  source = "./modules/ssh_key_aws"
  name_prefix="${var.key_name_prefix}"
}

module "ec2_instance" {
  source = "./modules/ec2_instances"
  ami = "${var.ami}"
  aws_key_name = "${module.ssh_key_aws.key_name}"
  subnet_ids = "${module.subnets.subnet_ids}"
  allow_ec2_access = "${module.security_groups.allow_ec2_access}"
  bastion_host_access  = "${module.security_groups.bastion_host_access}"
}


output "public_ip_bastion" {
  value = "${module.ec2_instance.publicIP}"
}

output "private_ip_target" {
  value = "${module.ec2_instance.privateIP}"
}