#criando uma maquina windows na aws 
resource "aws_instance" "web" {
  ami           = "ami-09a8cf76b6119ecd7"
  instance_type = "t3a.large"
  key_name      = "keypair-Fat-Proc-RPSLFVADVS"
  subnet_id     = var.subnet_publica_1_id
  
  vpc_security_group_ids = [
    "sg-02bbfd95dce21480b" #selecionando SG ja criado pelo console
  ]

  #colocando o root disk gp3 com 500gb
  root_block_device {
    volume_size           = "500"
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Fat-Proc-RPSLFVADVS"
  }
}

#criando elastic ip
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  vpc      = true
}