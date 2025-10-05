#!/bin/bash

# Terraform deployment script for Call Center Chatbot

set -e

TERRAFORM_DIR="../terraform"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting Terraform deployment..."

# Navigate to terraform directory
cd "$SCRIPT_DIR/$TERRAFORM_DIR"

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "📝 Creating terraform.tfvars from example..."
    cp terraform.tfvars.example terraform.tfvars
    echo "⚠️  Please edit terraform.tfvars with your values before continuing."
    echo "   Press Enter to continue or Ctrl+C to exit..."
    read
fi

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

# Validate configuration
echo "✅ Validating Terraform configuration..."
terraform validate

# Plan deployment
echo "📋 Planning deployment..."
terraform plan -out=tfplan

# Apply deployment
echo "🚀 Applying deployment..."
terraform apply tfplan

# Show outputs
echo "📊 Deployment outputs:"
terraform output

echo "✅ Deployment completed successfully!"
