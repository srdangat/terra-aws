# Terraform AWS VPC Module (Multi-Environment)

This Terraform module provisions an **AWS VPC** that can be reused across **multiple environments** (e.g. `dev`, `prod`) while storing Terraform state securely in **Amazon S3**.

---

## Features

- Supports **multiple environments** (`dev`, `prod`)
- Secure **remote state** stored in Amazon S3
- **Separate state file per environment**
- Environment-based **CIDR block configuration**
- **Public and private subnets**
- **Optional NAT Gateway**
- **Reusable and modular** Terraform design

---