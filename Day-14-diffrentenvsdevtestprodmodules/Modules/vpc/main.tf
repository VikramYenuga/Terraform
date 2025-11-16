
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_id
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-subnet"
  }
}


resource "aws_subnet" "name1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_1_id
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "name2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_2_id
  availability_zone = var.availability_zone2
}

output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "subnet_1_id" {
  value = "${aws_subnet.name1.id}"
}

output "subnet_2_id" {
  value = "${aws_subnet.name2.id}"
  
}