resource "aws_route_table" "terraform_route_table_public" {
  vpc_id     = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.internet_gateway_id}"
  }

  tags = {
    Name = "terraform-route-table-public"
  }
}

resource "aws_route_table" "terraform_route_table_private" {
  vpc_id     = "${var.vpc_id}"
  tags = {
    Name = "terraform-route-table-private"
  }
}

resource "aws_route_table_association" "terraform_route_table_association_public" {
  subnet_id = "${var.subnet_ids[1]}"
  route_table_id = "${aws_route_table.terraform_route_table_public.id}"
}

resource "aws_route_table_association" "terraform_route_table_association_private" {
  subnet_id = "${var.subnet_ids[0]}"
  route_table_id = "${aws_route_table.terraform_route_table_private.id}"
}