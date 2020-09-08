output "publicIP" {
  value = "${aws_instance.publicEC2.public_ip}"
}

output "privateIP" {
  value = "${aws_instance.privateEC2.private_ip}"
}