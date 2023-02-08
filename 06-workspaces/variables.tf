variable "aws_region" {
  description = "regiao aws onde serão criados os recursos"

  type = object(
    {
      dev  = string
      prod = string
    }
  )
  default = {
    dev  = "us-west-1"
    prod = "us-east-1"
  }
}

variable "instance" {
  description = "configuração da instancia por workspace"

  type = object({
    dev = object({
      ami    = string
      type   = string
      number = number
    })

    prod = object({
      ami    = string
      type   = string
      number = number
    })
  })

  default = {
    dev = {
      ami    = "ami-0036b4598ccd42565"
      number = 1
      type   = "t2.micro"
    }
    prod = {
      ami    = "ami-0aa7d40eeae50c9a9"
      number = 2
      type   = "t2.micro"
    }
  }

}