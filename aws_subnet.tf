
############### Create public subnets ##############

#resource "aws_subnet" "public" {
#  count = "${length(var.subnet_pb_cidr)}"
#  vpc_id = "${aws_vpc.vpc.id}"
#  availability_zone = "${element(var.azs_pb,count.index)}"
#  cidr_block = "${element(var.subnet_pb_cidr,count.index)}"
#  map_public_ip_on_launch = true

#  tags {
#    Name = "tf_subnet-${count.index +1}"
#  }
#}

resource "aws_subnet" "cloudgeek-public-1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "172.90.10.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-2a"

    tags {
        Name = "cloudgeek-public-1"
    }
}

############## create private subnet ####################

resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "172.90.20.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "ap-southeast-2b"

    tags {
        Name = "aws-private-1"
    }
}


############## create route table, attach internet gateway and associate with public subnets

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway_cloudgreek.id}"
  }

  tags {
     Name = "tf_route_table_public"
  }
 }


############### Attach route table with public subnets

resource "aws_route_table_association" "association" {
   count = "${length(var.subnet_pb_cidr)}"
   subnet_id = "${element(aws_subnet.cloudgeek-public-1.*.id, count.index)}"
   route_table_id = "${aws_route_table.public_rt.id}"
}

