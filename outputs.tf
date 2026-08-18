output "rds_endpoint" {
  description = "O endpoint de conexão para o banco de dados RDS MySQL"
  value       = aws_db_instance.mysql.endpoint
}

output "vpc_id" {
  description = "ID da VPC principal"
  value       = aws_vpc.main.id
}

output "s3_bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.storage.bucket
}
