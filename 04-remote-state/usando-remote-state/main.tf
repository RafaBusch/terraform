terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "tfstate-431591413306"
    key    = "dev/01-usando-remote-state/terraform.tfstate"
    region = "us-west-1"
  }
}
provider "aws" {
  region = var.aws_region
}