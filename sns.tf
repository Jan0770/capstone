resource "aws_sns_topic" "server_health" {
  name = "server_health"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.server_health.arn
  protocol  = "email"
  endpoint  = "sampleMail@sampleService.com"
}

# Non-functional as of now. 

# resource "aws_sns_topic_subscription" "lambda" {
#   topic_arn = aws_sns_topic.server_health.arn
#   protocol  = "lambda"
#   endpoint  = aws_lambda_function.unhealthy_instance_shutdown.arn
# }