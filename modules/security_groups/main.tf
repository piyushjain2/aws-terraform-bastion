resource "aws_security_group" "allow_ec2_access" {
  name        = "allow_ec2_access"
  description = "Allow connections"
  vpc_id     = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ec2_access"
  }
}

resource "aws_security_group" "bastion_host_access" {
  name        = "bastion_host_access"
  description = "Allow connection from bastion host"
  vpc_id     = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.allow_ec2_access.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_host_access"
  }
}