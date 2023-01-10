#criando ec2 amazon linux
resource "aws_instance" "ec2" {
  ami                    = "ami-00d8a762cb0c50254"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-publica-1.id
  key_name               = "key-teste-busch"
  vpc_security_group_ids = [aws_security_group.security-group.id] #associaçao do sg para essa instancia

  tags = {
    Name = "teste-busch"
  }
}