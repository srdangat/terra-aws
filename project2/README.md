# 🌐 Multi-Region VPC Peering with Terraform

This project provisions **two VPCs in different AWS regions** and connects them using **VPC Peering**.  
Each VPC contains a **public subnet**, **Internet Gateway**, **route tables**, **security groups**, and an **EC2 instance running Apache**.

---

## 🚀 What This Project Does

- Creates two VPCs in separate AWS regions  
- Deploys EC2 instances in each VPC  
- Installs Apache automatically  
- Configures VPC peering  
- Enables cross-VPC communication  
- Allows SSH and HTTP access  

---

## 🏗 Architecture Overview

- **Primary Region:** `us-east-1`
- **Secondary Region:** `ap-south-1`
- Non-overlapping CIDR ranges
- Bi-directional routing through VPC peering
