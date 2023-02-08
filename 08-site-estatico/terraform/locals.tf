locals {
  has_domain       = var.domain != ""
  domain           = local.has_domain ? var.domain : random_pet.website.id
  regional_domain  = module.website.regional_domain_name
  website_filepath = "${path.module}/../website"

  common_tags = {
    Project  = "curso aws com terraform"
    Service  = "site estatico"
    CriadoEm = "01-02-2023"
    Modulo   = "3"
    Dono     = "Rafael"
  }
}