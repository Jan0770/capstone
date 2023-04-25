resource "aws_autoscaling_group" "nf_asg" {
    name        = "nf-autoscaling"
    min_size    = 2
    max_size    = 6
    vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    target_group_arns   = [aws_lb_target_group.nf_lb_tg.id]
    
    depends_on = [
      aws_security_group.ssh_ingress
    ]

    launch_template {
        id = aws_launch_template.nf_launchtemplate.id
    }
}


resource "aws_launch_template" "nf_launchtemplate" {
    name            = "nf-launchtemplate"
    image_id        = var.ami
    instance_type   = var.instance_type
    key_name        = var.ssh_key
    user_data       =  base64encode(file("dockerWPuserdata.sh"))
    vpc_security_group_ids = [aws_security_group.ssh_ingress.id, aws_security_group.allow_http.id]
    
    monitoring {
      enabled = true
    }

    depends_on = [
      aws_security_group.ssh_ingress
    ]
} 

resource "aws_autoscaling_policy" "scale_out_policy" {
    autoscaling_group_name  = aws_autoscaling_group.nf_asg.id
    name                    = "scale-out-policy"
    scaling_adjustment      = 1 
    adjustment_type         = "ChangeInCapacity"
    policy_type             = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scale_in_policy" {
    autoscaling_group_name  = aws_autoscaling_group.nf_asg.id
    name                    = "scale-in-policy"
    scaling_adjustment      = -1 
    adjustment_type         = "ChangeInCapacity"
    policy_type             = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "scale_out" {
    alarm_name              = "nf-scale-out-alarm"
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
        "AutoScalingGroupName" = "${aws_autoscaling_group.nf_asg.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "scale_in" {
    alarm_name              = "nf-scale-in-alarm"
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
        "AutoScalingGroupName" = "${aws_autoscaling_group.nf_asg.name}"
    }
} 