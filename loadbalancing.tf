resource "aws_lb" "nf_lb" {
    name                = "load-balancer"
    load_balancer_type  = "application"
    security_groups     = [aws_security_group.ssh_ingress.id, aws_security_group.allow_http.id]
    internal            = false
    subnets             = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    
    depends_on = [
      aws_vpc.nf_vpc
    ]
}

resource "aws_lb_listener" "nf_lb_listener" {
    load_balancer_arn   = aws_lb.nf_lb.id
    port                = 80
    protocol            = "HTTP"

    depends_on = [
      aws_lb.nf_lb
    ]
    default_action {
      target_group_arn  = aws_lb_target_group.nf_lb_tg.id
      type              = "forward"
    }
}

resource "aws_lb_target_group" "nf_lb_tg" {
    name        = "nf-lb-tg"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.nf_vpc.id
    target_type = "instance"

    depends_on = [
      aws_lb.nf_lb
    ]

    health_check {
        port        = 80
        protocol    = "HTTP"
        path = "/"
        matcher = "404"
    }
}

resource "aws_autoscaling_attachment" "nf" {
    autoscaling_group_name  = aws_autoscaling_group.nf_asg.id
    lb_target_group_arn     = aws_lb_target_group.nf_lb_tg.arn
}
