# RDS Module - Outputs

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.db_instance.address
}

output "db_port" {
    description = "The port of the RDS instance"
    value       = aws_db_instance.db_instance.port
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.db_instance.db_name
}

output "db_instance_id" {
    description = "The ID of the RDS Instance"
    value = aws_db_instance.db_instance.id
}