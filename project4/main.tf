provider "aws" {
  region = var.aws_region
}

module "secrets" {
  source       = "./modules/secrets"
  project_name = var.project_name
  environment  = var.environment
  db_username  = var.db_username
}

module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source               = "./modules/rds"
  project_name         = var.project_name
  environment          = var.environment
  db_security_group_id = module.security_groups.db_sg_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = module.secrets.db_password
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  engine_version       = var.engine_version
}

module "ec2" {
  source                = "./modules/ec2"
  project_name          = var.project_name
  environment           = var.environment
  instance_type         = var.instance_type
  key_name              = var.key_name
  public_subnet_id      = module.vpc.public_subnet_id
  web_security_group_id = module.security_groups.web_sg_id
  db_name               = var.db_name
  db_host               = module.rds.db_instance_endpoint
  db_username           = var.db_username
  db_password           = module.secrets.db_password
}
