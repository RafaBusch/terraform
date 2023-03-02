variable "service_name" {
  type = string
  #description = ""
  default = "todos"
}

variable "service_domain" {
  type    = string
  default = "api-todos"
}

variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "aws_account_id" {
  type        = number
  description = ""
  default     = 431591413306
}
