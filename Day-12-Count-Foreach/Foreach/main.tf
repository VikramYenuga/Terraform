variable "env" {
    type = list(string)
    default = [ "dev","prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t3.micro"
    for_each = toset(var.env) 
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = each.value
    }
}