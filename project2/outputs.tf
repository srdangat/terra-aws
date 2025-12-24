output "primary_vpc_id" {
  description = "Primary Vpc Id"
  value       = aws_vpc.primary_vpc.id
}

output "secondary_vpc_id" {
  description = "Secondary Vpc Id"
  value       = aws_vpc.secondary_vpc.id
}

output "primary_vpc_cidr" {
  description = "Primary Vpc CIDR Block"
  value       = aws_vpc.primary_vpc.cidr_block
}

output "secondary_vpc_cidr" {
  description = "Secondary Vpc CIDR Block"
  value       = aws_vpc.secondary_vpc.cidr_block
}

output "primary_ec2_id" {
  description = "Primary Ec2 ID"
  value       = aws_instance.primary_ec2.id
}

output "secondary_ec2_id" {
  description = "Secondary Ec2 ID"
  value       = aws_instance.secondary_ec2.id
}

output "primary_ec2_public_ip" {
  description = "Primary EC2 Public IP"
  value       = aws_instance.primary_ec2.public_ip
}

output "secondary_ec2_public_ip" {
  description = "Secondary EC2 Public IP"
  value       = aws_instance.secondary_ec2.public_ip
}


output "primary_ec2_private_ip" {
  description = "Primary EC2 Private IP"
  value       = aws_instance.primary_ec2.private_ip
}

output "secondary_ec2_private_ip" {
  description = "Secondary EC2 Priavte IP"
  value       = aws_instance.secondary_ec2.private_ip
}

output "primary_ec2_ssh" {
  description = "SSH command to connect to Primary EC2"
  value       = "ssh -i ${var.primary_key_path} ubuntu@${aws_instance.primary_ec2.public_ip}"
}


output "secondary_ec2_ssh" {
  description = "SSH command to connect to Secondary EC2"
  value       = "ssh -i ${var.secondary_key_path} ubuntu@${aws_instance.secondary_ec2.public_ip}"
}
