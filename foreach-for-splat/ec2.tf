data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"
}

resource "aws_instance" "this" {

  for_each = {
    "web" = {
      name = "web-server"
      type = "t3.micro"
    }
    ci_cd = {
      name = "cicd-server"
      type = "t2.micro"
    }
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = lookup(each.value, "type", null)

  tags = {
    project = "curso-aws-terraform"
    Name    = "${each.key}: ${lookup(each.value, "name", null)}"
    lesson  = "foreach, for, splat"
  }
}