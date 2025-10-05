# Terraform Infrastructure

This directory contains Terraform configuration for deploying the Call Center Chatbot infrastructure.

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured
- Lambda deployment package in `../versions/chatbot_api_working.zip`

## Quick Start

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Create variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   ```

3. **Plan deployment:**
   ```bash
   terraform plan
   ```

4. **Deploy infrastructure:**
   ```bash
   terraform apply
   ```

## Resources Created

- **Lambda Function**: Serverless chatbot API
- **IAM Role**: Lambda execution role with Bedrock permissions
- **Function URL**: Public HTTPS endpoint
- **CloudWatch Logs**: Function logging

## Outputs

After deployment, Terraform will output:
- Lambda function name and ARN
- Function URL for API access
- IAM role ARN

## Cleanup

```bash
terraform destroy
```
