# Key Pair
resource "aws_key_pair" "example" {
  key_name   = "test"
  public_key = file("~/.ssh/id_ed25519.pub")
}

#instance
resource "aws_instance" "server" {
  ami                         = "ami-00af95fa354fdb788" # amazon AMI
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.example.key_name
  
}