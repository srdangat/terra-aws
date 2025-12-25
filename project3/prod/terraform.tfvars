region                  = "us-east-1"
environment             = "Prod"
vpc_cidr_block          = "10.1.0.0/16"
enable_dns_hostnames    = true
enable_dns_support      = true
map_public_ip_on_launch = true
public_subnets          = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnets         = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]