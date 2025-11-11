provider "aws" {
    region = "ap-south-1"

  
}
provider "aws" {
    region = "us-east-2"
    alias = "Ohio"
    profile = "vikram-1"
  
}