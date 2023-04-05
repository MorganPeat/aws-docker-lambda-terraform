#
# Deploy a python lamda function
#
# For more info, see:
# - https://docs.aws.amazon.com/lambda/latest/dg/lambda-python.html
#



# Required trust policy that allows Lambda to assume the function's execution role.
data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

# Execution role for the function, defining the permissions that the
# Lambda needs and allowing the Lambda function to assume it.
# More info at https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html
resource "aws_iam_role" "lambda_role" {
  name                = "iam_for_aws_docker_lambda_terraform"
  assume_role_policy  = data.aws_iam_policy_document.lambda_trust_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}


resource "aws_lambda_function" "lambda" {
  function_name = "aws-docker-lambda-terraform"
  role          = aws_iam_role.lambda_role.arn

  # URI comes from the output of the packer build, once the image is pushed to ECR
  image_uri     = var.image_uri
  package_type  = "Image" # case sensitive
  architectures = ["x86_64"]
}

# Just here to provide an output variable
resource "aws_lambda_function_url" "latest" {
  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"
}
