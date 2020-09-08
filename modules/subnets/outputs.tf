output "subnet_ids" {
  value = [ "${aws_subnet.private.id}", "${aws_subnet.public.id}" ]
}