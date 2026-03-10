data "aws_ami" "test" {
    filter {
      name = "name"



      values = [ "spacelift-1743980649-x86_64" ]
    }
  
}
output "ami_id" {
  value = data.aws_ami.test.id
}