#creating listener for external load balancer
resource "aws_lb_listener" "external" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"
    
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tier.arn
  }
}

#creating listener for internal load balancer
resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tier.arn
  }
}