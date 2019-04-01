#create NAT Gateway
resource "aws_eip" "nat"{
 vpc = "true"
}

resource "aws_nat_gateway" "nat_gw"{
 allocation_id = "${aws_eip.nat.id}"
 subnet_id = "${aws_subnet.main-pubsubnet-1.id}"
 depends_on = ["aws_internet_gateway.main-gw"]
}

#VPC for NAT
resource "aws_route_table" "main-private" {
 vpc_id = "${aws_vpc.main.id}"
 route {
 cidr_block = "0.0.0.0/0"
 nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
 }
 tags {
 Name = "main-private"
 }
}

#create aws_route_table_association for private subnets
resource "aws_route_table_association" "main-private-1a" {
 subnet_id = "${aws_subnet.main-prisubnet-1.id}"
 route_table_id = "${aws_route_table.main-private.id}"
}

resource "aws_route_table_association" "main-private-1b" {
 subnet_id = "${aws_subnet.main-prisubnet-2.id}"
 route_table_id = "${aws_route_table.main-private.id}"
}


