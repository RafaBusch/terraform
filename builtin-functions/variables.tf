variable "env" {

}

variable "aws_region" {
  type        = string
  description = ""
  default     = "us-west-1"
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-00d8a762cb0c50254"

  validation {
    condition     = length(var.instance_ami) > 4 && substr(var.instance_ami, 0, 4) == "ami-"
    error_message = "A instancia precisa comecar com \"ami-\"."
  }
}

variable "instance_number" {
  type = object({
    dev  = number
    prod = number
  })

  description = "Numero de instancias para criar"
  default = {
    dev  = 1
    prod = 3
  }
}

variable "instance_type" {
  type = object({
    dev  = string
    prod = string
  })

  description = ""
  default = {
    dev  = "t2.micro"
    prod = "t2.medium"
  }
}
