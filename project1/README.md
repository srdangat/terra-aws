# Static Website Hosting on AWS (S3 + CloudFront + Route 53) using Terraform

This project provisions a **secure static website** on AWS using **Terraform**.The website content is stored in a **private S3 bucket**, served through **CloudFront**, and exposed via a custom domain using **Route 53**.

## Architecture

- **Amazon S3 (Private Bucket)**  
  Stores static website files (HTML, CSS, JS, assets)

- **Amazon CloudFront**  
  Serves content globally with low latency  
  Uses **Origin Access Control (OAC)** or **Origin Access Identity (OAI)** to securely access S3

- **Amazon Route 53**  
  Manages DNS records for the custom domain

- **AWS Certificate Manager (ACM)**  
  Provides an SSL/TLS certificate for HTTPS (required in `us-east-1` for CloudFront)

---

### Request Flow

**User → Route 53 → CloudFront → Private S3 Bucket**

---

## Features

- Private S3 bucket (no public access)
- CloudFront distribution with HTTPS
- Secure S3 access via CloudFront only
- Custom domain with Route 53
- Infrastructure as Code (IaC) using Terraform
