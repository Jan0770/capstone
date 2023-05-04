resource "aws_lb" "loadbalancer" {
    name                = "loadbalancer"
    load_balancer_type  = "application"
    security_groups     = [aws_security_group.host_security.id]
    internal            = false
    subnets             = [aws_subnet.host_subnet_1.id, aws_subnet.host_subnet_2.id]
    
    depends_on = [
      aws_vpc.vpc
    ]
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn   = aws_lb.loadbalancer.id
    port                = 80
    protocol            = "HTTP"

    depends_on = [
      aws_lb.loadbalancer
    ]
    default_action {
      target_group_arn  = aws_lb_target_group.target.id
      type              = "forward"
    }
}

resource "aws_lb_target_group" "target" {
    name        = "target"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.vpc.id
    target_type = "instance"

    depends_on = [
      aws_lb.loadbalancer
    ]

    health_check {
        port      = 80
        protocol  = "HTTP"
        path      = "/"
        matcher   = "302"
    }
}

resource "aws_autoscaling_attachment" "nf" {
    autoscaling_group_name  = aws_autoscaling_group.asg.id
    lb_target_group_arn     = aws_lb_target_group.target.arn
}
