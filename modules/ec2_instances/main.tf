resource "aws_instance" "publicEC2" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    subnet_id = "${var.subnet_ids[1]}" 
    associate_public_ip_address = true
    vpc_security_group_ids = ["${var.allow_ec2_access}"]
}

resource "aws_instance" "privateEC2" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    subnet_id = "${var.subnet_ids[0]}" 
    vpc_security_group_ids = ["${var.bastion_host_access}"]
}