
# Terraform  NG
resource "aws_eip" "cloudgeek-nat" {
vpc      = true
}

resource "aws_nat_gateway" "cloudgeek-nat-gw" {
allocation_id = "${aws_eip.cloudgeek-nat.id}"
subnet_id = "${aws_subnet.cloudgeek-public-1.id}"
depends_on = ["aws_internet_gateway.gateway_cloudgreek"]
}

# Terraform VPC for NAT
resource "aws_route_table" "cloudgeek-private" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.cloudgeek-nat-gw.id}"
    }

    tags {
        Name = "cloudgeek-private-1"
    }
}

# Terraform private routes
resource "aws_route_table_association" "cloudgeek-private-ass" {
    subnet_id = "${aws_subnet.private.id}"
    route_table_id = "${aws_route_table.cloudgeek-private.id}"
}
