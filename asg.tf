#Creating Auto Scaling Group for Web Tier
resource "aws_autoscaling_group" "web_tier" {
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  desired_capacity    = var.asg_web_dc
  max_size            = var.asg_web_max
  min_size            = var.asg_web_min


  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}






#Creating an Auto Scaling Group for App Tier
resource "aws_autoscaling_group" "app_tier" {
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  desired_capacity    = var.asg_app_dc
  max_size            = var.asg_app_max
  min_size            = var.asg_app_min

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}




