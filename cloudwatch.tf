
resource "aws_cloudwatch_metric_alarm" "scale_out" {
    alarm_name              = "cap-scale-out-alarm"
    comparison_operator     = "GreaterThanOrEqualToThreshold"
    evaluation_periods      = 1
    metric_name             = "CPUUtilization"
    namespace               = "AWS/EC2"
    period                  = 60
    statistic               = "Average"
    threshold               = 70
    alarm_description       = "Alarm for reaching >70% CPU threshold"
    alarm_actions           = [aws_autoscaling_policy.scale_out_policy.arn]
    
    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "scale_in" {
    alarm_name              = "cap-scale-in-alarm"
    comparison_operator     = "LessThanOrEqualToThreshold"
    evaluation_periods      = 1
    metric_name             = "CPUUtilization"
    namespace               = "AWS/EC2"
    period                  = 60
    statistic               = "Average"
    threshold               = 20
    alarm_description       = "Alarm for reaching <20% CPU threshold"
    alarm_actions           = [aws_autoscaling_policy.scale_in_policy.arn]
    
    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
    }
} 

# resource "aws_cloudwatch_metric_alarm" "healthy_hosts" {
#     alarm_name          = "healthy_hosts"
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#     evaluation_periods  = 1
#     metric_name         = "HealthyHostCount"
#     namespace           = "AWS/ApplicationELB"
#     period              = 60
#     statistic           = "Average"
#     threshold           = 2
#     alarm_description   = "Service is healthy and available"
#     alarm_actions       = [aws_sns_topic.server_health.arn]

#     dimensions = {
#         "TargetGroup" = "${aws_lb_target_group.target.name}"
#     }
# }