data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloudlog" {
  name                          = "cloudlog"
  s3_bucket_name                = aws_s3_bucket.logbucket.id
  include_global_service_events = false
}

resource "aws_s3_bucket" "logbucket" {
  bucket        = "logbucket"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "logpolicy" {
  bucket = aws_s3_bucket.logbucket.id
  policy = data.aws_iam_policy_document.allow_cloudtrail.json
}

# IAM policy non-functionla due to sandbox restriction

# data "aws_iam_policy_document" "allow_cloudtrail" {
#   statement {
#     sid    = "AWSCloudTrailWrite"
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }

#     actions   = ["s3:PutObject"]
#     resources = ["${aws_s3_bucket.logbucket.arn}//AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "s3:x-amz-acl"
#       values   = ["bucket-owner-full-control"]
#     }
#   }
# }
