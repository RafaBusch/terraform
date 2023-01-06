variable "aws_region" {
  type        = string
  description = ""
  default     = "us-west-1"
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-00d8a762cb0c50254"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"
}

variable "intance_tags" {
  type        = map(string)
  description = ""
  default = {
    "Name"    = "Ubuntu"
    "Project" = "curso AWS com terraform"
  }
}