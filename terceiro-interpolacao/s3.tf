resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.environment}"

  tags = local.common_tags #local sem "s" usa para referenciar alguma variavel do locals
  #e common_tags é o nome do locals declarado no outro arquivo (na mesma pasta)

}

resource "aws_s3_object" "this" { # o "this" é o nome do bucket aqui no terraform, caso fosse subir
  #outros buckets teriam outros nomes declarados aqui
  bucket = aws_s3_bucket.this.bucket
  key    = "config/${local.ip_filepath}"
  source = local.ip_filepath
  etag   = filemd5(local.ip_filepath)
}