resource "aws_security_group" "web" {
  name        = "Web"
  description = "allow public inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80 # http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 # https
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.this["pvt_a"].cidr_block]
  }

  tags = merge(local.common_tags, { Name = "Web Server" })
}

resource "aws_security_group" "db" {
  name        = "Db"
  description = "allow incoming database connections"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 3306 #porta mysql
    to_port         = 3306 #porta mysql
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    from_port   = 22 #ssh
    to_port     = 22 #ssh
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 80 # http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443 # https
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Database Mysql" })
}

resource "aws_security_group" "alb" {
  name        = "ALB-SG"
  description = "load balancer sg"
  vpc_id      = aws_vpc.this.id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, { Name = "Load Balancer" })
}

resource "aws_security_group" "autoscaling" {
  name        = "autoscaling"
  description = "sg allows ssh/http and all egress"
  vpc_id      = aws_vpc.this.id


  ingress {
    from_port   = 22 #ssh
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80 #http
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, { Name = "auto-scaling" })
}

resource "aws_security_group" "jenkins" {
  name        = "jenkins"
  description = "allow incoming connections to jenkins machine"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 22 #ssh
    to_port     = 22 #ssh
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port       = 22 #ssh
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  tags = merge(local.common_tags, { Name = "jenkins-machine" })
}