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
    user_data       =  base64encode(file("dockerWP.sh"))
    vpc_security_group_ids = [aws_security_group.host_security.id]
    
    monitoring {
      enabled = true
    }

    depends_on = [
      aws_security_group.host_security
    ]
} 

