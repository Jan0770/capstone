resource "aws_sns_topic" "server_health" {
  name = "server_health"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.server_health.arn
  protocol  = "email"
  endpoint  = "sample@sample.com"
}

