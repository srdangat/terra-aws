# Get the list of available AZs in the region
data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = {
      Name        = "${var.project_name}-${var.environment}-vpc"
      Environment = var.environment
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
    tags = {
      Name        = "${var.project_name}-${var.environment}-igw"
      Environment = var.environment
    }
  
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
    tags = {
      Name        = "${var.project_name}-${var.environment}-public-subnet-${count.index + 1}"
      Environment = var.environment
    }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
      Name        = "${var.project_name}-${var.environment}-private-subnet-${count.index + 1}"
      Environment = var.environment
    }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
      Name        = "${var.project_name}-${var.environment}-public-rt"
      Environment = var.environment
    }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
        tags = {
        Name        = "${var.project_name}-${var.environment}-private-rt"
        Environment = var.environment
        }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}