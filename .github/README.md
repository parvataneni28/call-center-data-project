# GitHub Actions Setup

## Required Secrets

Add these secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Click Settings → Secrets and variables → Actions
3. Add the following repository secrets:

### AWS Credentials
- `AWS_ACCESS_KEY_ID`: Your AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key

## Workflow Triggers

- **Push to main**: Automatically deploys to AWS
- **Pull Request**: Runs tests only

## Deployment Process

1. Tests run on all branches
2. Deployment only happens on main branch
3. Creates Lambda deployment package
4. Deploys infrastructure with Terraform
5. Outputs the Function URL for testing

## Manual Deployment

If you need to deploy manually:

```bash
cd deployment/scripts
./terraform-deploy.sh
```
