region                  = "us-east-1"
environment             = "Dev"
vpc_cidr_block          = "10.0.0.0/16"
enable_dns_hostnames    = true
enable_dns_support      = true
map_public_ip_on_launch = true
public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets         = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]