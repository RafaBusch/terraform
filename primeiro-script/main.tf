terraform {
  required_version = "1.3.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "bucketcriadocomterraformbusch-2"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Managedby   = "terraform"
    Owner       = "Rafael"
    Atualizado  = "05/12"
  }
}