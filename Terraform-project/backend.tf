/*
resource "aws_instance" "backend" {
  ami = var.ami
  instance_type = var.instance-type
  key_name = var.key-name
  subnet_id = aws_subnet.prvt5.id
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  tags = {name="back_end"}
  user_data = file("backend.sh")
}
*/