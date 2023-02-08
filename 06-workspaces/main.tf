terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "tfstate-431591413306"
    key            = "05-workspaces/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "tflock-tfstate-431591413306"
  }
}

provider "aws" {
  region = lookup(var.aws_region, local.env)
}

locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
}

resource "aws_instance" "web" {
  count = lookup(var.instance, local.env)["number"]

  ami           = lookup(var.instance, local.env)["ami"]
  instance_type = lookup(var.instance, local.env)["type"]

  tags = {
    "Name" = "minha maquina web ${local.env}"
    Env    = local.env
  }
}