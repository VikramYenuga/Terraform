resource "aws_instance" "name" {
  ami           = "ami-01760eea5c574eb86"
  instance_type = "t3.micro"
  tags = {
    Name = "vikram"
  }
}

#terraform Import==>terraform import aws_instance.name <instance_Id>
#After that we take refeance from terraform.tfstate file (like what we wirte in aws_ec2)then add to main.tf in resource block

resource "aws_s3_bucket" "name" {
  bucket = "terraformsbuckets123"
}

#terraform import ==>terraform import aws_s3_bucket.name <s3_bucket_name> write as id
#After that we take refeance from terraform.tfstate file (like what we wirte in aws_s3)then add to main.tf in resource block
