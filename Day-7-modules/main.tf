resource "aws_instance" "name" {
  ami           = var.ami
  instance_type = var.type
  
  tags = {
    Name = "dev"
  }
}
resource "aws_vpc" "name" {
  cidr_block = var.vpc

}
