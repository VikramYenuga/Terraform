# lamdba_iam_role
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# lamdba_iam_policy
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#lamdba_cloudwatch_policy
resource "aws_iam_role_policy" "lambda_cloudwatch_policy" {
  name = "lambda_cloudwatch_logs_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# create aws_s3_bucket
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "awedcfvbhiuytresxcvbnjkiuytresxcvbnjjhgfdghj"
}

#create object and upload zip file
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "appp.zip"
  source = "appp.zip"
  etag   = filemd5("appp.zip")
}

#create lamdba
resource "aws_lambda_function" "my_lambda" {
  function_name = "lambda_s3"
  role          = aws_iam_role.lambda_role.arn
  handler       = "appp.lambda_handler"
  runtime       = "python3.12"
  timeout       = 900
  memory_size   = 128

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = aws_s3_object.lambda_zip.key
}

#create cloudwatch
resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda-schedule-rule"
  description         = "Triggers Lambda every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

#create cloudwatch_event_target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "lambda"
  arn       = aws_lambda_function.my_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}
