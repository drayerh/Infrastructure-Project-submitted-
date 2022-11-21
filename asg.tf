#Configuring Auto Scaling for Web Tier
#creating an autoscaling group
resource "aws_autoscaling_group" "web_tier" {
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 2

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}









#Creating an Auto Scaling Group for App Tier
resource "aws_autoscaling_group" "app_tier" {
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 2

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}




