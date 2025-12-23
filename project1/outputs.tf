output "cdn_custom_domain" {
  description = "Custom domain name pointing to the CloudFront distribution"
  value       = "https://${aws_route53_record.cdn.fqdn}"
}


output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket used as the CloudFront origin"
  value       = aws_s3_bucket.bucket.id
}