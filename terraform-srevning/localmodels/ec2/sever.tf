resource "aws_instance" "one" {
  instance_type = var.instance_type
  count = var.number_of_instance
  ami = data.aws_ami.test.id
}