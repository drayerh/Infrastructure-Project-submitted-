#web Auto Scaling Attachment to External ALB
resource "aws_autoscaling_attachment" "web_tier" {
  autoscaling_group_name = aws_autoscaling_group.web_tier.id
  elb                    = aws_lb.external.id
}

#Auto Scaling Attachment to Internal ALB 
resource "aws_autoscaling_attachment" "app_tier" {
  autoscaling_group_name = aws_autoscaling_group.app_tier.id
  elb                    = aws_lb.internal.id
}