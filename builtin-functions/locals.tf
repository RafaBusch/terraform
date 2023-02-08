locals {
  instance_number = lookup(var.instance_number, var.env)

  file_ext    = "zip"
  object_name = "arquivo-gerado-template"

  common_tags = {
    "dono" = "Rafael Busch"
    "ano"  = "2022"
  }
}