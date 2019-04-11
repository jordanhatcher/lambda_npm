provider "aws" {}

module "lambda_npm" {
  source             = "./lambda_npm"
  function_name      = "jhatcher_example_function"
  function_directory = "./function_code"
  role               = "${aws_iam_role.iam_for_lambda.arn}"
  handler            = "index.handler"
  runtime            = "nodejs8.10"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
