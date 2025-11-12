# resource "aws_instance" "name" {
#     ami = "ami-01760eea5c574eb86"
#     instance_type = "t3.micro"
#     count = 3                           #WIth same name, and we add index we use ${count-index}
#     tags = {
#       Name = "dev"                                              
#     }
# #   tags = {
# #       Name = "dev-${count.index}"          # In this type we add index like(0,1,2)by this we add name like (dev,prod)we use variable
# #     }
# }

variable "env" {
    type = list(string)
    default = [ "dev","prod","vikram"]        #we add names in variable we call like "count=length(var.env)"
  
}

resource "aws_instance" "name" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t3.micro"
    count = length(var.env)           #we call name like in variable like "tags={name=var.env[count,index]}" 
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index]
    }
}



# In this count we remove mid name 0r index-->replaced with last id is delete mid id replace with last index or name
# like
# for this issuse we call foreach.
