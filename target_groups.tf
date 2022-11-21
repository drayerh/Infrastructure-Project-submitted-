#creating target group for instances in web tier
resource "aws_lb_target_group" "web_tier" {
  name     = "my-web-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id

  health_check = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 60
    path                = "/"
    protocol            = "HTTP"
    timeout             = 60
  }

tags = {
    Name = var.tags[0]
}
}

#creating target group for instances in app tier
resource "aws_lb_target_group" "app_tier" {
  name     = "my-app-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id

  health_check = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 60
    path                = "/"
    protocol            = "HTTP"
    timeout             = 60
  }
tags = {
    Name = var.tags[0]
}
}