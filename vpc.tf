#Create main VPC for my AWS
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 instance_tenancy = "default"
 enable_dns_support = "true"
 enable_dns_hostnames = "true"
 enable_classiclink =  "false"
 tags {
 Name = "main"
 }
}

#Create a public subnets in diffrent regions
resource "aws_subnet" "main-pubsubnet-1" {
 vpc_id = "${aws_vpc.main.id}"
 cidr_block = "10.0.1.0/24"
 map_public_ip_on_launch = "true"
 availability_zone = "us-east-1a"
 tags {
 Name = "main-pubsubnet-1"
 }
}

resource "aws_subnet" "main-pubsubnet-2" {
 vpc_id = "${aws_vpc.main.id}"
 cidr_block = "10.0.2.0/24"
 map_public_ip_on_launch = "true"
 availability_zone = "us-east-1b"
 tags {
 Name = "main-pubsubnet-2"
 }
}

#Create private subnets in diffrent regoins
resource "aws_subnet" "main-prisubnet-1" {
 vpc_id = "${aws_vpc.main.id}"
 cidr_block = "10.0.3.0/24"
 map_public_ip_on_launch = "false"
 availability_zone = "us-east-1a"
 tags {
 Name = "main-prisubnet-1"
 }
}

resource "aws_subnet" "main-prisubnet-2" {
 vpc_id = "${aws_vpc.main.id}"
 cidr_block = "10.0.4.0/24"
 map_public_ip_on_launch = "false"
 availability_zone = "us-east-1b"
 tags {
 Name = "main-prisubnet-2"
 }
}

#Create internet Gateway
resource "aws_internet_gateway" "main-gw" {
 vpc_id = "${aws_vpc.main.id}"
 tags {
 Name = "main"
 }
}

#Create route tables
resource "aws_route_table" "main-public" {
 vpc_id = "${aws_vpc.main.id}"
 route {
 cidr_block = "0.0.0.0/0"
 gateway_id = "${aws_internet_gateway.main-gw.id}"
 }
 tags{
 Name = "main-public"
 }
}

#create aws_route_table_association for public subnets
resource "aws_route_table_association" "main-public-1a" {
 subnet_id = "${aws_subnet.main-pubsubnet-1.id}"
 route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-2a" {
 subnet_id = "${aws_subnet.main-pubsubnet-2.id}"
 route_table_id = "${aws_route_table.main-public.id}"
}

