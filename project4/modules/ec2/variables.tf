variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_id" {
  description = "IDs of the public subnets"
  type        = string
}

variable "web_security_group_id" {
  description = "Security group ID for the web server"
  type        = string
}


variable "key_name" {
  description = "Key pair name for EC2 instance"
  type        = string
}



variable "db_host" {
  description = "Database host endpoint"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
}
