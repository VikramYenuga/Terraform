provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::312695118602:role/tf-role"
    session_name = "terraform-access"
  }
}