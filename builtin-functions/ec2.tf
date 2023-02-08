resource "aws_instance" "ec2" {
  count = local.instance_number <= 0 ? 0 : local.instance_number #essa é uma builtin function (funcao nativa do terraform)

  ami           = var.instance_ami
  instance_type = lookup(var.instance_type, var.env)

  tags = merge(
    local.common_tags,
    {
      Project = "curso aws com terraform"
      env     = format("%s", var.env)
      name    = format("instance %d", count.index + 1)
    }
  )
}