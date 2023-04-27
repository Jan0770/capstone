resource "aws_autoscaling_group" "asg" {
    name        = "capstone-autoscaling"
    min_size    = var.asg_min_size
    max_size    = var.asg_max_size
    desired_capacity    = var.asg_desired_capacity
    vpc_zone_identifier = [aws_subnet.host_subnet_1.id, aws_subnet.host_subnet_2.id]
    target_group_arns   = [aws_lb_target_group.target.arn]
    
    depends_on = [
      aws_security_group.host_security,
      aws_rds_cluster_instance.clusterinstance
    ]

    launch_template {
        id = aws_launch_template.launchtemplate.id
    }
}


resource "aws_launch_template" "launchtemplate" {
    name            = "cap-launchtemplate"
    image_id        = var.ami
    instance_type   = var.instance_type
    key_name        = var.ssh_key
    user_data       =  base64encode(file("dockerMySQL.sh"))
    vpc_security_group_ids = [aws_security_group.host_security.id]
    
    monitoring {
      enabled = true
    }

    depends_on = [
      aws_security_group.host_security
    ]
} 

resource "aws_autoscaling_policy" "scale_out_policy" {
    autoscaling_group_name  = aws_autoscaling_group.asg.id
    name                    = "scale-out-policy"
    scaling_adjustment      = 1 
    adjustment_type         = "ChangeInCapacity"
    policy_type             = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scale_in_policy" {
    autoscaling_group_name  = aws_autoscaling_group.asg.id
    name                    = "scale-in-policy"
    scaling_adjustment      = -1 
    adjustment_type         = "ChangeInCapacity"
    policy_type             = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "scale_out" {
    alarm_name              = "cap-scale-out-alarm"
    comparison_operator     = "GreaterThanOrEqualToThreshold"
    evaluation_periods      = 1
    metric_name             = "CPUUtilization"
    namespace               = "AWS/EC2"
    period                  = 60
    statistic               = "Average"
    threshold               = 70
    alarm_description       = "alarm for reaching >70% CPU threshold"
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
    alarm_description       = "alarm for reaching <20% CPU threshold"
    alarm_actions           = [aws_autoscaling_policy.scale_in_policy.arn]
    
    dimensions = {
        "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
    }
} 