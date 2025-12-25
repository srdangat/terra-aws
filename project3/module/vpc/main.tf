# Get the list of available AZs in the region
data "aws_availability_zones" "available" {}

# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  tags = {
    Name = "${var.environment}-Vpc"
    Environment = var.environment
  ManagedBy   = "Terraform"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-Igw"
    Environment = var.environment
  ManagedBy   = "Terraform"
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  count = length(var.public_subnets)
  cidr_block = var.public_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.environment}-public-subnet${count.index + 1}"
    Environment = var.environment
  ManagedBy   = "Terraform"
  }
}

# Create Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.vpc.id
  count = length(var.private_subnets)
  cidr_block = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.environment}-private-subnet${count.index + 1}"
    Environment = var.environment
  ManagedBy   = "Terraform"
  }
}

# Create Public RT
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-Public-RT"
    Environment = var.environment
  ManagedBy   = "Terraform"
  }
}

# Public Subnets Associations
resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
   tags = {
    Name = "${var.environment}-Private-RT"
    Environment = var.environment
  ManagedBy   = "Terraform"
  }
}


# Private Subnets Associations
resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}