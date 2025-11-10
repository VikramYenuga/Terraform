data "aws_ami" "example" {
  most_recent = true
  owners      = ["amazon"] # Replace with the AWS account ID if needed

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Use your AMI name pattern
  }
}

# Launch Template Resource
resource "aws_launch_template" "frontend" {
  name = "frontend-terraform"
  description = "frontend-terraform"
  image_id = var.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
 # key_name = var.key_name #chnage the key 
 #key_name = "existing-keypair-name"
 key_name = aws_key_pair.my_key.key_name
  user_data = filebase64("${path.module}/fronend.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-terraform"
    }
  }
}

###################################################################################
data "aws_ami" "example1" {
  most_recent = true
  owners      = ["amazon"] # Replace with the AWS account ID if needed

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Use your AMI name pattern
  }
}


# Launch Template Resource
resource "aws_launch_template" "backend" {
  name = "backend-terraform"
  description = "backend-terraform"
  image_id = var.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  #key_name = var.key_name 
  # key_name = "existing-keypair-name"
   key_name = aws_key_pair.my_key.key_name
     user_data = filebase64("${path.module}/backend.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-terraform"
    }
  }
}