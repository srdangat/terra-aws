resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.project_name}-${var.environment}-db-subnet-group"
  description = "DB subnet group for ${var.project_name}-${var.environment}"
  subnet_ids  = var.private_subnet_ids
}

resource "aws_db_instance" "db_instance" {
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  instance_class         = var.instance_class
  storage_type           = "gp2"
  allocated_storage      = var.allocated_storage
  engine                 = "mysql"
  engine_version         = var.engine_version
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  multi_az               = false
  skip_final_snapshot    = true
}