#deixando a versao do terraform fixa
terraform {
  required_version = "1.3.7"
}
#escolhendo provedor aws
provider "aws" {
  region = "us-west-1"
}

#criando uma key pair para a ec2
resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}
#escolhendo o tipo de key
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#criando um arquivo na maquina para deixar a secret key
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

#pegando os dados da ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
#criando uma maquina ubuntu na aws 
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "TF_key"
  tags = {
    Name = "teste key pair com Terraform"
  }
}