# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

# VPC CIDR
output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

# Public Subnet IDs
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

# Private Subnet IDs
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id
}

# Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Public Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id
}

# Private Route Table ID
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_rt.id
}
