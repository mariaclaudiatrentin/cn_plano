resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier            = "${var.project_name}-mysql"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  multi_az = true

  backup_retention_period = 7
  backup_window           = "03:00-04:00"

  skip_final_snapshot = true
  publicly_accessible = false
  deletion_protection = false

  tags = {
    Name   = "${var.project_name}-mysql"
    Backup = "true"
  }
}
