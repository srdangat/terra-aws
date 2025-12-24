# Primary VPC in us-east-1
resource "aws_vpc" "primary_vpc" {
  provider             = aws.primary
  cidr_block           = var.primary_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Primary-Vpc-${var.primary_region}"
    Environment = "Test"
    Purpose     = "Vpc Peering Test"
  }
}

# Secondary VPC in ap-south-1
resource "aws_vpc" "secondary_vpc" {
  provider             = aws.secondary
  cidr_block           = var.secondary_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Secondary-Vpc-${var.secondary_region}"
    Environment = "Test"
    Purpose     = "Vpc Peering Test"
  }
}

# Subnet in Primary VPC
resource "aws_subnet" "primary_subnet" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = var.primary_subnet_cidr
  availability_zone       = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "Primary-Subnet-${var.primary_region}"
    Environment = "Test"
  }
}

# Subnet in Secondary VPC 
resource "aws_subnet" "secondary_subnet" {
  provider                = aws.secondary
  vpc_id                  = aws_vpc.secondary_vpc.id
  cidr_block              = var.secondary_subnet_cidr
  availability_zone       = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name        = "Secondary-Subnet-${var.secondary_region}"
    Environment = "Test"
  }
}

# Internet Gateway for Primary VPC
resource "aws_internet_gateway" "primary_gw" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary_vpc.id

  tags = {
    Name        = "Primary-Igw"
    Environment = "Test"
  }
}

# Internet Gateway for Secondary VPC
resource "aws_internet_gateway" "secondary_gw" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary_vpc.id

  tags = {
    Name        = "Secondary-Igw"
    Environment = "Test"
  }
}


# Route table for Primary VPC
resource "aws_route_table" "primary_route" {
  provider = aws.primary
  vpc_id   = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_gw.id
  }

  tags = {
    Name        = "Primary-Route-Table"
    Environment = "Test"
  }
}

# Route Table for Secondary VPC
resource "aws_route_table" "secondary_route" {
  provider = aws.secondary
  vpc_id   = aws_vpc.secondary_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary_gw.id
  }

  tags = {
    Name        = "Secondary-Route-Table"
    Environment = "Test"
  }
}

# Associate route table with Primary subnet
resource "aws_route_table_association" "primary_rta" {
  provider       = aws.primary
  subnet_id      = aws_subnet.primary_subnet.id
  route_table_id = aws_route_table.primary_route.id
}


# Associate route table with Secondary subnet
resource "aws_route_table_association" "secondary_rta" {
  provider       = aws.secondary
  subnet_id      = aws_subnet.secondary_subnet.id
  route_table_id = aws_route_table.secondary_route.id
}


# VPC Peering Connection (Requester side - Primary VPC)
resource "aws_vpc_peering_connection" "primary_to_secondary" {
  provider    = aws.primary
  peer_vpc_id = aws_vpc.secondary_vpc.id
  vpc_id      = aws_vpc.primary_vpc.id
  peer_region = var.secondary_region
  auto_accept = false

  tags = {
    Name        = "Primary-to-Secondary-Peering"
    Environment = "Test"
    Side        = "Requester"
  }
}

# Vpc Peering Connection (Acceptor side - Secondary VPC)
resource "aws_vpc_peering_connection_accepter" "secondary_accepter" {
  provider                  = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id
  auto_accept               = true

  tags = {
    Name        = "Secondary-Peering-Accepter"
    Environment = "Test"
    Side        = "Accepter"
  }
}

# Add route to Secondary VPC in Primary route table
resource "aws_route" "primary_to_secondary" {
  provider                  = aws.primary
  route_table_id            = aws_route_table.primary_route.id
  destination_cidr_block    = var.secondary_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}

# Add route to Primary VPC in Secondary route table
resource "aws_route" "secondary_to_primary" {
  provider                  = aws.secondary
  route_table_id            = aws_route_table.secondary_route.id
  destination_cidr_block    = var.primary_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}


# Security Group for Primary VPC EC2 instance
resource "aws_security_group" "primary_sg" {
  provider    = aws.primary
  description = "primary vpc sg"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from secondary"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.secondary_vpc_cidr]
  }

  ingress {
    description = "All traffic from secondary"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.secondary_vpc_cidr]
  }

  egress {
    description = "All Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Secondary VPC EC2 instance
resource "aws_security_group" "secondary_sg" {
  provider    = aws.secondary
  description = "secondary vpc sg"
  vpc_id      = aws_vpc.secondary_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from primary"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.primary_vpc_cidr]
  }

  ingress {
    description = "All traffic from primary"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.primary_vpc_cidr]
  }

  egress {
    description = "All Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance in Primary VPC
resource "aws_instance" "primary_ec2" {
  provider               = aws.primary
  ami                    = data.aws_ami.primary_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.primary_subnet.id
  key_name               = var.primary_key_name
  vpc_security_group_ids = [aws_security_group.primary_sg.id]
  user_data              = local.primary_user_data
  tags = {
    Name        = "Primary-VPC-Instance"
    Environment = "Test"
    Region      = var.primary_region
  }

  depends_on = [aws_vpc_peering_connection.primary_to_secondary]
}


# EC2 Instance in Secondary VPC
resource "aws_instance" "secondary_ec2" {
  provider               = aws.secondary
  ami                    = data.aws_ami.secondary_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.secondary_subnet.id
  key_name               = var.secondary_key_name
  vpc_security_group_ids = [aws_security_group.secondary_sg.id]
  user_data              = local.secondary_user_data
  tags = {
    Name        = "Secondary-VPC-Instance"
    Environment = "Test"
    Region      = var.secondary_region
  }

  depends_on = [aws_vpc_peering_connection.primary_to_secondary]
}
