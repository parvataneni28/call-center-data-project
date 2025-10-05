# API Documentation

## Call Center Chatbot API

### Endpoint
- **URL**: AWS Lambda Function URL or API Gateway endpoint
- **Method**: POST
- **Content-Type**: application/json

### Request Format

```json
{
    "question": "string",
    "context": "string (optional)"
}
```

### Response Format

```json
{
    "statusCode": 200,
    "body": {
        "response": "string",
        "timestamp": "ISO 8601 timestamp"
    }
}
```

### Example Usage

```bash
curl -X POST https://your-lambda-url.amazonaws.com/ \
  -H "Content-Type: application/json" \
  -d '{"question": "How do I reset my password?"}'
```

### Supported Question Types

- Account management
- Technical support
- Billing inquiries
- General information
- Troubleshooting guides
