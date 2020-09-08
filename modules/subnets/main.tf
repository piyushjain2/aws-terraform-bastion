resource "aws_subnet" "private" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Terraform Private Subnet"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "Terraform Public Subnet"
  }
}