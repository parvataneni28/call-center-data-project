# Call Center Chatbot API

A serverless chatbot API built with AWS Lambda and Amazon Bedrock for call center support.

## Project Structure

```
├── src/                           # Source code
│   └── lambda_function.py         # Main Lambda function
├── tests/                         # Test files and results
│   ├── test_all_questions.sh      # Test script
│   └── *.txt                      # Test results
├── deployment/                    # Deployment artifacts
│   ├── versions/                  # Lambda deployment packages
│   ├── infrastructure/            # AWS infrastructure configs
│   ├── terraform/                 # Infrastructure as Code
│   └── scripts/                   # Deployment scripts
├── docs/                          # Documentation
├── requirements.txt               # Python dependencies
└── README.md                      # This file
```

## Features

- AWS Lambda-based serverless architecture
- Amazon Bedrock integration for AI responses
- Call center specific question handling
- Automated testing suite

## Quick Start

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Deploy with Terraform (recommended):
   ```bash
   cd deployment/scripts
   ./terraform-deploy.sh
   ```

   Or deploy with AWS CLI:
   ```bash
   cd deployment/scripts
   ./deploy.sh
   ```

3. Run tests:
   ```bash
   cd tests
   ./test_all_questions.sh
   ```

## Deployment

- **Terraform**: Infrastructure as Code in `deployment/terraform/`
- **Packages**: Lambda deployment packages in `deployment/versions/`
- **Infrastructure**: AWS policies and configs in `deployment/infrastructure/`
- **Scripts**: Automated deployment in `deployment/scripts/`

## Testing

Test scripts and results are available in the `tests/` directory. The latest test results show comprehensive coverage of call center scenarios.
