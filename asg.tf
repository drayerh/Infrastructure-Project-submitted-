#Configuring Auto Scaling for Web Tier
#creating a placement group
resource "aws_placement_group" "web_tier" {
  name     = "web tier instances placement group"
  strategy = "cluster"
}

#creating an autoscaling group
resource "aws_autoscaling_group" "web_tier" {
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1

  launch_template {
    id      = aws_launch_template.web_tier.id
    version = "$Latest"
  }
}

#Creating launch template for Web Tier Auto Scaling Group
resource "aws_launch_template" "web_tier" {
  name_prefix   = "web_tier_launch_template"
  image_id      = "ami-0648ea225c13e0729"
  instance_type = "t2.micro"
}


#Creating an Auto Scaling Attachment for Web Servers
resource "aws_autoscaling_attachment" "web_tier" {
  autoscaling_group_name = aws_autoscaling_group.web_tier.id
  elb                    = aws_elb.external.id
}



#Configuring Auto Scaling for App Tier
#creating a placement group
resource "aws_placement_group" "app_tier" {
  name     = "app tier instances placement group"
  strategy = "cluster"
}

#creating an autoscaling group
resource "aws_autoscaling_group" "app_tier" {
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1

  launch_template {
    id      = aws_launch_template.app_tier.id
    version = "$Latest"
  }
}


#Creating launch template for App Tier Auto Scaling Group
resource "aws_launch_template" "app_tier" {
  name_prefix   = "app_tier_launch_template"
  image_id      = "ami-0648ea225c13e0729"
  instance_type = "t2.micro"
}


#Creating an Auto Scaling Attachment for App Servers
resource "aws_autoscaling_attachment" "app_tier" {
  autoscaling_group_name = aws_autoscaling_group.app_tier.id
  elb                    = aws_lb.internal.id
}
