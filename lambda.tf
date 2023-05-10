# Non-functional due to sandbox restrictions. 

# data "archive_file" "lambda" {
#   type        = "zip"
#   source_file = "unhealthyInstanceShutdown.py"
#   output_path = "lambda_function_payload.zip"
# }

# resource "aws_lambda_function" "unhealthy_instance_shutdown" {
#   filename      = "lambda_function_payload.zip"
#   function_name = "unhealthy_instance_shutdown"
#   role          = aws_iam_role.LabRole.arn
#   runtime       = "python3.8"
#   timeout       = 10
#   handler       = lambda_function.lambda_handler
# }