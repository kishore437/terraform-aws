############### create security group ############

resource "aws_security_group" "webservers" {
   name = "allow_http"
   description = "allow http inbound traffic"
   vpc_id = "${aws_vpc.vpc.id}"

   ingress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
    Name = "webserver-sg"
  }
 }

resource "aws_security_group" "database_server" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = "${var.subnet_pb_cidr}"
  }

  tags = {
    Name = "database-sg"
  }
}

