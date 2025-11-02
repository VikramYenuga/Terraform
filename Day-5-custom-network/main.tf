#create VPC
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "cus-vpc" }
}
#create subnets
resource "aws_subnet" "name" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "cus-1-public"
  }
}
resource "aws_subnet" "name-1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "cus-2-private"
  }
}
#create internet gateway
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id

}
#create route table & edit route
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }

}
#create subnet association
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.name.id
  route_table_id = aws_route_table.name.id

}
#create security group
resource "aws_security_group" "name" {
  name   = "allow_tls"
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "cus-sg"
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#create Instance
resource "aws_instance" "name" {
  ami                         = "ami-01760eea5c574eb86"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.name.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    Name = "cus-public"
  }
}
#create eip
resource "aws_eip" "name" {
  domain = "vpc"
}
#create NAT
resource "aws_nat_gateway" "name" {
  subnet_id     = aws_subnet.name.id
  allocation_id = aws_eip.name.id
  depends_on    = [aws_internet_gateway.name]

}
#create RT for private subnet and nat 
resource "aws_route_table" "name1" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.name.id
  }
}
#create RT association for Internet to Private
resource "aws_route_table_association" "name1" {
  route_table_id = aws_route_table.name1.id
  subnet_id      = aws_subnet.name-1.id

}

#create private instance
resource "aws_instance" "name1" {
  ami                    = "ami-01760eea5c574eb86"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.name.id
  vpc_security_group_ids = [aws_security_group.name.id]
  tags = {
    Name = "cus-private"
  }

}
