resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
}

resource "aws_subnet" "private1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.private_cidr_block1}"
  availability_zone = "${var.region}a"

}

resource "aws_subnet" "private2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.private_cidr_block2}"
  availability_zone = "${var.region}b"

}

resource "aws_subnet" "private3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.private_cidr_block3}"
  availability_zone = "${var.region}c"

}

resource "aws_subnet" "public1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public_cidr_block1}"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"

}

resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public_cidr_block2}"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}b"

}

resource "aws_subnet" "public3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public_cidr_block3}"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}c"

}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

}

resource "aws_route_table" "publicrt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.publicrt.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.publicrt.id}"
}

resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.publicrt.id}"
}

resource "aws_eip" "nat" {
   vpc  = true
 }
 resource "aws_nat_gateway" "ngw" {
   allocation_id = "${aws_eip.nat.id}"
   subnet_id     = "${aws_subnet.public1.id}"
 }

 resource "aws_route_table" "privatert" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"
  }

}

resource "aws_route_table_association" "d" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.privatert.id}"
}

resource "aws_route_table_association" "e" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.privatert.id}"
}

resource "aws_route_table_association" "f" {
  subnet_id      = "${aws_subnet.private3.id}"
  route_table_id = "${aws_route_table.privatert.id}"
}