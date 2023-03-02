locals {
  lambdas_path = "${path.module}/../app/lambdas"
  layers_path  = "${path.module}/../app/layers/nodejs"
  layer_name   = "joi.zip"

  common_tags = {
    Project       = "ToDo servesless app"
    CriadoEm      = "14-02-2023"
    GerenciadoPor = "Terraform"
    Dono          = "Rafael Busch"
    Service       = var.service_name
  }
}