terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "null_resource" "null" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "echo $FOO $BAR $BAZ $TIME >> env_vars.txt"

    environment = {
      FOO = "bar"
      BAR = 1
      BAZ = "true"
      TIME = timestamp()
    }
  }

  provisioner "local-exec" {
    command = "rm -rf nodejs-app && mkdir nodejs-app && cd nodejs-app && npm init -y && npm install joi"
  }
}