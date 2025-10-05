# Infrastructure Configuration

This directory contains AWS infrastructure configuration files.

## Files

### IAM Policies
- `lambda-trust-policy.json` - Trust policy for Lambda execution role
- `chatbot-permissions.json` - Basic chatbot permissions
- `chatbot-permissions-nova.json` - Enhanced permissions for Nova model

### S3 Bucket Policies
- `bucket-policy-fix.json` - Fixed bucket policy
- `athena-bucket-policy.json` - Athena query results bucket policy
- `athena-bucket-policy-fix.json` - Fixed Athena bucket policy

## Usage

These files are used during AWS infrastructure setup. Apply them in the following order:
1. Lambda trust policy
2. Chatbot permissions
3. S3 bucket policies
