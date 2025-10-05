#!/bin/bash

# Call Center Chatbot Deployment Script
# This script deploys the Lambda function and sets up required infrastructure

set -e

FUNCTION_NAME="call-center-chatbot"
REGION="us-east-1"
ROLE_NAME="call-center-chatbot-role"

echo "Starting deployment of Call Center Chatbot..."

# Check if AWS CLI is configured
if ! aws sts get-caller-identity > /dev/null 2>&1; then
    echo "Error: AWS CLI not configured. Please run 'aws configure' first."
    exit 1
fi

# Deploy Lambda function
echo "Deploying Lambda function..."
aws lambda update-function-code \
    --function-name $FUNCTION_NAME \
    --zip-file fileb://versions/chatbot_api_working.zip \
    --region $REGION

echo "Deployment completed successfully!"
