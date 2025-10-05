variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "call-center-chatbot"
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "call-center-chatbot"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}
