variable "function_name" {}

variable "function_directory" {}

variable "role" {}

variable "handler" {}

variable "runtime" {}

variable "environment" {
    type = "map"
    default = {}
}
