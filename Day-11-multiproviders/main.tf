resource "aws_instance" "name" {
  ami="ami-01760eea5c574eb86"
  instance_type = "t3.micro"

}

resource "aws_s3_bucket" "name" {
    bucket = "tybuwbdsjbcscjasdfghjk"
    provider = aws.oregon
  
}