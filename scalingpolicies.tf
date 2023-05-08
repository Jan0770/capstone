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
