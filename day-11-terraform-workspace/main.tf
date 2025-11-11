resource "aws_instance" "workspace" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t3.micro"
  
}