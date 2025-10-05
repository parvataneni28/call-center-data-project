output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.chatbot.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.chatbot.arn
}

output "function_url" {
  description = "Lambda function URL"
  value       = aws_lambda_function_url.chatbot_url.function_url
}

output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_role.arn
}
