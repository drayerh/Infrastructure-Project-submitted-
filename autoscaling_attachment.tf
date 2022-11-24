#web Auto Scaling Attachment to web target group
resource "aws_autoscaling_attachment" "web-tier" {
  autoscaling_group_name = aws_autoscaling_group.web_tier.id
  alb_target_group_arn   = aws_lb_target_group.web-tier-target-group.arn
}

#Auto Scaling Attachment to App target group
resource "aws_autoscaling_attachment" "app-tier" {
  autoscaling_group_name = aws_autoscaling_group.app_tier.id
  alb_target_group_arn   = aws_lb_target_group.app-tier-target-group.arn
}