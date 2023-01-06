locals { #para declarar as locals deve estar no plural

  ip_filepath = "ips.json" #ta dando o caminho do arquivo "ips.json" que está na msm pasta do main
  #por isso nao precisou de  barras (/home/user...)

  common_tags = {

    Service     = "curso terraform"
    ManagedBy   = "terraform"
    Environment = var.environment
    Owner       = "Rafael"
  }
}