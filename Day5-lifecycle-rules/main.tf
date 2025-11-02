resource "aws_instance" "name" {
  ami           = "ami-01760eea5c574eb86"
  instance_type = "t3.micro"
  tags          = { Name = "test" }

  #lifecycle {
  # create_before_destroy = true
  #}                  #it means it create before destroy

  #lifecycle {
  # create_before_destroy = false # it means first destroy after create
  #}

  #lifecycle {
  # ignore_changes = [tags, ]
  #}                            # it means ignore the changes

  #lifecycle {
  # prevent_destroy = true             # prevent_destroy==>Instance cannot be destroyed commnly
  #}

  lifecycle {
    prevent_destroy = false # Instance can be destroyed by using prevent_destroy=false
  }

}

