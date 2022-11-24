#creating target group for instances in web tier
resource "aws_lb_target_group" "web-tier-target-group" {
  name     = "my-web-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id

  health_check {
    interval            = 100
    path                = "/"
    protocol            = "HTTP"
    timeout             = 60
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = var.tags[0]
  }
}

#creating target group for instances in app tier
resource "aws_lb_target_group" "app-tier-target-group" {
  name     = "my-app-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id

  health_check {
    interval            = 100
    path                = "/"
    protocol            = "HTTP"
    timeout             = 60
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = var.tags[0]
  }
}