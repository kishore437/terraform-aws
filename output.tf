######################## output ##########################

output "elb-dns" {
   value = "${aws_elb.cloudgeek-elb.dns_name}"
}


