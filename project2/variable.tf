variable "primary_region" {
  description = "Primary AWS region for the first VPC"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "Secondary AWS region for the second VPC"
  type        = string
  default     = "ap-south-1"
}


variable "primary_vpc_cidr" {
  description = "CIDR block for the primary VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "secondary_vpc_cidr" {
  description = "CIDR block for the secondary VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "primary_subnet_cidr" {
  description = "CIDR block for the primary subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "secondary_subnet_cidr" {
  description = "CIDR block for the secondary subnet"
  type        = string
  default     = "192.168.0.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "primary_key_name" {
  description = "Name of the SSH key pair for Primary VPC instance (us-east-1)"
  type        = string
  default     = "primary-vpc"
}

variable "secondary_key_name" {
  description = "Name of the SSH key pair for Secondary VPC instance (ap-south-1)"
  type        = string
  default     = "secondary-vpc"
}


variable "primary_key_path" {
  type    = string
  default = "local pem key path"
}

variable "secondary_key_path" {
  type    = string
  default = "local pem key path"
}