# Terraform AWS Web Application Stack (Flask + RDS MySQL)

This project demonstrates deploying a **complete web application stack on AWS** using **Terraform** with a **modular architecture**. The infrastructure is designed following AWS best practices, separating public and private resources for improved security and scalability.

---

## 🏗 Architecture Overview

The stack includes the following components:

- **VPC**
  - Public subnets for internet-facing resources
  - Private subnets for backend services

- **EC2 Instance**
  - Ubuntu-based EC2 instance
  - Runs a **Flask web application**
  - Located in a public subnet with internet access

- **RDS MySQL Database**
  - Deployed in **private subnets**
  - Not publicly accessible
  - Securely accessed by the EC2 instance

- **Security Groups**
  - Control inbound and outbound traffic
  - Restrict database access to the EC2 instance only