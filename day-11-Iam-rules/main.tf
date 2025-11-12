
##################FullAccess-role###########
resource "aws_iam_role" "admin_role" {
  name = "admin-role-tf1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" 
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


###############AWS-EC2 to S3############

# 1️⃣ Create IAM Role for EC2
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-role-tf1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 2️⃣ Attach AmazonS3FullAccess managed policy
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

##########role ec2-lamdba--s3##########

#  Create IAM Role for EC2 and Lambda
resource "aws_iam_role" "ec2_lambda_s3_role" {
  name = "ec2-lambda-s3-role-tf1"

  # Allow both EC2 and Lambda to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "lambda.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#  Attach S3 Full Access policy
resource "aws_iam_role_policy_attachment" "s3_full_access-2" {
  role       = aws_iam_role.ec2_lambda_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

#  Attach basic Lambda execution permissions (recommended)
resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.ec2_lambda_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

