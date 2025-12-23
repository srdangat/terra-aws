# Get existing Route53 Hosted Zone
data "aws_route53_zone" "primary" {
  name         = "cloud2devops.online"
  private_zone = false
}

# Get existing ACM certificate (must be in us-east-1 for CloudFront)
data "aws_acm_certificate" "cdn_cert" {
  domain      = "cloud2devops.online"
  statuses    = ["ISSUED"]
  most_recent = true
}