resource "aws_s3_bucket" "this" {
    bucket = "${random_pet.bucket.id}-${var.environment}"

    tags = {
      "Service" = "Curso"
      "ManagedBy" = "terraform"
      "Environment" = var.environment
      "Owner" = "Rafael"
    }
  
}