provider "aws" {
    region = "us-west-1"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "bucketcriadocomterraformbusch"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Managedby   = "terraform"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}