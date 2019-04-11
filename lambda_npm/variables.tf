variable "function_name" {
  description = "Name of the lambda function"
}

variable "function_directory" {
  description = "Relative directory that contains the lambda code as well as a package.json file"
}

variable "role" {
  description = "Role ARN for the lambda function"
}

variable "handler" {
  description = "Entrypoint for the lambda function"
}

variable "runtime" {
  description = "Lambda function runtime"
}

variable "environment" {
  description = "Map of environment variable names and values"
  type = "map"
  default = {}
}
