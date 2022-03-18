output "id" {
  value = "${aws_vpc.vpc1.id}"
}

output "sub1_id" {
  value = "${aws_subnet.public.id}"
}
