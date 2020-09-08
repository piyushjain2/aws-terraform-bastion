output "allow_ec2_access" {
  value = "${aws_security_group.allow_ec2_access.id}"
}

output "bastion_host_access" {
  value = "${aws_security_group.bastion_host_access.id}"
}