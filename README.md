# lambda_npm

Example of a terraform module that automatically installs NPM
packages, zips them up with the lambda code, and deploys the lambda function.

Currently, only a subset of the `aws_lambda_function` resources' parameters are
supported.

## Usage:
```hcl
module "lambda_npm" {
  source             = "./lambda_npm"

  function_name      = "${var.function_name}"
  function_directory = "${var.function_directory}"
  role               = "${var.role}"
  handler            = "${var.handler}"
  runtime            = "${var.runtime}"
  environment = {
    FUNCTION_NAME = "${var.function_name}"
  }
}
```