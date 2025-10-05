# Architecture Overview

## System Architecture

The Call Center Chatbot is built using a serverless architecture on AWS:

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Client    │───▶│ API Gateway │───▶│   Lambda    │
│ Application │    │             │    │  Function   │
└─────────────┘    └─────────────┘    └─────────────┘
                                             │
                                             ▼
                                    ┌─────────────┐
                                    │   Amazon    │
                                    │   Bedrock   │
                                    └─────────────┘
```

## Components

### AWS Lambda
- **Runtime**: Python 3.9+
- **Memory**: 512MB (configurable)
- **Timeout**: 30 seconds
- **Trigger**: API Gateway or Function URL

### Amazon Bedrock
- **Model**: Claude/Nova (configurable)
- **Purpose**: Natural language processing and response generation
- **Integration**: AWS SDK (boto3)

### IAM Roles & Policies
- Lambda execution role with Bedrock permissions
- S3 access for logging and data storage
- CloudWatch Logs for monitoring

## Data Flow

1. Client sends HTTP POST request with question
2. API Gateway routes to Lambda function
3. Lambda processes request and calls Bedrock
4. Bedrock generates AI response
5. Lambda returns formatted response to client

## Security

- IAM-based access control
- VPC integration (optional)
- Encryption in transit and at rest
- API throttling and rate limiting
