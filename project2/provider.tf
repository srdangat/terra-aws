# Provider for the primary region (us-east-1)
provider "aws" {
  region = var.primary_region
  alias  = "primary"
}

# Provider for the secondary region (ap-south-1)
provider "aws" {
  region = var.secondary_region
  alias  = "secondary"
}