provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../module/vpc"

  region                  = var.region
  environment             = var.environment
  vpc_cidr_block          = var.vpc_cidr_block
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support
  public_subnets          = var.public_subnets
  private_subnets         = var.private_subnets
  map_public_ip_on_launch = var.map_public_ip_on_launch
}