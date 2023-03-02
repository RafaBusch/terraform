variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "aws_account_id" {
  type    = number
  default = 431591413306
}

variable "service_name" {
  type    = string
  default = "autoscaling-app"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_key_name" {
  type    = string
  default = "busch-key-terraform"
}