#criando uma key pair para a ec2
resource "aws_key_pair" "key-teste-busch" {
  key_name   = "key-teste-busch"
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