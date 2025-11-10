resource "aws_instance" "back1" {
    ami = var.ami
    instance_type = var.instance-type
    key_name = var.key_name
  # key_name = "existing-keypair-name"
 #key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.pub1.id
    vpc_security_group_ids = [aws_security_group.bastion-host.id ]
    tags = {
      Name= "bastion-server"
    }
}
