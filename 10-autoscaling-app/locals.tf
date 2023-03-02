locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    Projeto       = "CursoAWScomTerraform"
    CriadoEm      = "24-02-2023"
    GerenciadoPor = "Terraform"
    Dono          = "RafaelBusch"
    Service       = "AutoScalingApp"
  }
}
