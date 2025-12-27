resource "random_password" "db_password" {
  length = 16
  special = true
  override_special = "!@#$%&*()-_=+[]{}<>?"
}


resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.project_name}-${var.environment}-db-password"
  description = "Database password for ${var.project_name} in ${var.environment} environment"
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    engine   = "mysql"
    host     = "${var.project_name}-${var.environment}-db.${var.environment}.rds.amazonaws.com"
  })
}