# Define the provisioner to run local commands to install npm packages
resource "null_resource" "npm" {
  triggers = {
    package_json_hash = "${filesha256("${var.function_directory}/package.json")}"
  }

  provisioner "local-exec" {
    command = "cd ${var.function_directory} && npm install"
  }
}

# Create the ZIP archive containing the npm packages and the lambda function sources
data "archive_file" "lambda_zip" {
  # This data resource will always be read due to the issue:
  # https://github.com/hashicorp/terraform/issues/11806
  depends_on  = ["null_resource.npm"]

  type        = "zip"
  source_dir  = "${var.function_directory}"
  output_path = "${path.module}/tmp/${var.function_name}.zip"
}

# Create the actual lambda function
resource "aws_lambda_function" "function" {
  filename         = "${data.archive_file.lambda_zip.output_path}"
  function_name    = "${var.function_name}"
  role             = "${var.role}"
  handler          = "${var.handler}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "${var.runtime}"
  environment {
    variables = "${merge(local.environment, var.environment)}"
  }
}

locals {
  environment = {
    FUNCTION_NAME = "${var.function_name}"
  }
}
