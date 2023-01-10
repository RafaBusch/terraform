#criando sg para liberar ssh do meu ip
resource "aws_security_group" "security-group" {
  name        = "sg_ssh_myip"
  description = "SG para liberar meu ip para acesso via ssh"
  vpc_id      = aws_vpc.vpc.id

#poderia ter o ingress aqui mas escolhi nao deixar ja que os codigos abaixo vão liberar meu ip
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

#criando uma regra para permitir ssh do meu ip
data "external" "whatismyip" {
  program = ["/bin/bash", "${path.module}/whatismyip.sh"]
}
resource "aws_security_group_rule" "allow_ssh_from_my_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [format("%s/%s", data.external.whatismyip.result["internet_ip"], 32)]
  security_group_id = aws_security_group.security-group.id
  description       = "habilita o ssh para o meu ip"
}