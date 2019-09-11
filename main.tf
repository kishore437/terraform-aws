
############ Create VPC ########################

resource "aws_vpc" "vpc" {
   cidr_block = "${var.vpc_cidr}"
   enable_dns_hostnames = true
   enable_dns_support   = true
   instance_tenancy     = "default"   
   
   tags {
     Name = "tf_cloudgreek_vpc"
   }
}

############# Create Internet Gateway #############

resource "aws_internet_gateway" "gateway_cloudgreek" {
   vpc_id = "${aws_vpc.vpc.id}"

   tags {
     Name = "tf_cloudgreek_internetgateway"
   }
}


################### aws web-server instance ##################

resource "aws_instance" "webservers" {
  count = "${length(var.subnet_pb_cidr)}"
  ami = "${var.webservers_ami}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.webservers.id}"]
  subnet_id = "${element(aws_subnet.cloudgeek-public-1.*.id,count.index)}"
  user_data = "${file("install_httpd.sh")}"
  
  tags {
   Name = "server-${count.index}"
  }
}

##################### aws database-server #######################

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  final_snapshot_identifier = "false"
}
  

  
