# Creating External LoadBalancer
resource "aws_lb" "external" {
  name            = "ayerhvpc-external-lb"
  internal        = false
  security_groups = [aws_security_group.ext_lb.id]
  subnets         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.web_tier_1.id, aws_instance.web_tier_2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.tags[0]
  }
}


#creating target group for instances in web tier
resource "aws_lb_target_group" "web_tier" {
  name     = "my-web-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id
}

resource "aws_lb_listener" "external" {
  load_balancer_arn = aws_elb.external.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:elasticloadbalancing:us-west-2:123456789012:listener/app/my-load-balancer/50dc6c495c0c9188/f2f7dc8efc522ab2 --certificates CertificateArn=arn:aws:acm:us-west-2:123456789012:certificate/5cc54884-f4a3-4072-80be-05b9ba72f705"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tier.arn
  }
}

resource "aws_lb_target_group_attachment" "web_tier_1" {
  target_group_arn = aws_lb_target_group.web_tier.arn
  target_id        = aws_instance.web_tier_1.id
  port             = 80

  depends_on = [
    aws_instance.web_tier_1
  ]
}

resource "aws_lb_target_group_attachment" "web_tier_2" {
  target_group_arn = aws_lb_target_group.web_tier.arn
  target_id        = aws_instance.web_tier_2.id
  port             = 80

  depends_on = [
    aws_instance.web_tier_2
  ]
}








#Creating an Internal Elastic Load Balancer

# Creating External LoadBalancer
resource "aws_lb" "internal" {
  name                       = "ayerhvpc-internal-alb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.app_tier.id]
  subnets                    = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "app_tier" {
  name     = "my-app-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id
}

resource "aws_lb_target_group_attachment" "app_tier_1" {
  target_group_arn = aws_lb_target_group.app_tier.arn
  target_id        = aws_instance.app_tier_1.id
  port             = 80

  depends_on = [
    aws_instance.app_tier_1
  ]
}

resource "aws_lb_target_group_attachment" "app_tier_2" {
  target_group_arn = aws_lb_target_group.web_tier.arn
  target_id        = aws_instance.app_tier_2.id
  port             = 80

  depends_on = [
    aws_instance.web_tier_2
  ]
}

resource "aws_lb_listener" "listener2" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tier.arn
  }
}



