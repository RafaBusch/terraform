#criacao da subnet publica
resource "aws_subnet" "subnet-publica-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true" #sem essa linha a subnet seria privada
  availability_zone       = "${var.region}b"

  tags = {
    Name = "subnet-publica-1"
  }
}

#criacao da subnet publica 2
resource "aws_subnet" "subnet-publica-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true" #sem essa linha a subnet seria privada
  availability_zone       = "${var.region}c"

  tags = {
    Name = "subnet-publica-2"
  }
}

#criacao da subnet privada
resource "aws_subnet" "subnet-privada-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.10.0/24"
  # map_public_ip_on_launch = "true" - sem essa linha a subnet seria privada
  availability_zone = "${var.region}b"

  tags = {
    Name = "subnet-privada-1"
  }
}

#criacao da subnet privada 2
resource "aws_subnet" "subnet-privada-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.15.0/24"
  # map_public_ip_on_launch = "true" - sem essa linha a subnet seria privada
  availability_zone = "${var.region}c"

  tags = {
    Name = "subnet-privada-2"
  }
}

#criando associacao com public subnet 1
resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.subnet-publica-1.id
  route_table_id = aws_route_table.route-table.id
}

#criando associacao com public subnet 2
resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.subnet-publica-2.id
  route_table_id = aws_route_table.route-table.id
}

#criando associacao com public subnet 1
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.subnet-privada-1.id
  route_table_id = aws_route_table.route-table.id
}

#criando associacao com public subnet 2
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.subnet-privada-2.id
  route_table_id = aws_route_table.route-table.id
}
