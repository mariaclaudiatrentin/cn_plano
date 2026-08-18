variable "aws_region" {
  description = "Região da AWS onde a infraestrutura será criada Fatec297"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto para ser usado em tags"
  type        = string
  default     = "docker-mysql-fatec297"
}

variable "vpc_cidr" {
  description = "CIDR block para a VPC"
  type        = string
  default     = "10.297.0.0/16"
}

variable "ec2_instance_type" {
  description = "Tipo de instância EC2 para computação Docker"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "Classe da instância do RDS MySQL"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Nome do banco de dados inicial"
  type        = string
  default     = "nuvem297"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = "fatec297"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "Fatec297nuvens"
}

variable "s3_bucket_name" {
  description = "Nome do bucket S3 para armazenamento"
  type        = string
  default     = "fatec297-app-storage"
}
