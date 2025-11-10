/*resource "aws_instance" "frontend" {
  ami = var.ami
  instance_type = var.instance-type
  key_name = var.key-name
  subnet_id = aws_subnet.prvt3.id
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  tags = {name="front_end"}
  user_data = file("fronend.sh")
}
*/