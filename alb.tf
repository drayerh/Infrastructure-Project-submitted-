# Creating External LoadBalancer
resource "aws_lb" "external" {
  name                       = "ayerhvpc external alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.web_tier.id]
  subnets                    = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "web_tier" {
  name     = "my web tier target group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ayerhvpc.id
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.web_tier.arn
  target_id        = aws_instance.demoinstance1.id
  port             = 80

  depends_on = [
    aws_instance.demoinstance1
  ]
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = aws_instance.demoinstance2.id
  port             = 80

  depends_on = [
    aws_instance.demoinstance2
  ]
}

resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_elb.arn
  }
}

#Creating an Internal Elastic Load Balancer
resource "aws_lb" "internal" {
  name                       = "ayerhvpc internal alb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.demosg.id]
  subnets                    = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "target_elb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demovpc.id
}

resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = aws_instance.demoinstance1.id
  port             = 80

  depends_on = [
    aws_instance.demoinstance1
  ]
}

resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = aws_instance.demoinstance2.id
  port             = 80

  depends_on = [
    aws_instance.demoinstance2
  ]
}

resource "aws_lb_listener" "listener2" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_elb.arn
  }
}
resource "aws_lb" "example" {
  name               = "example"
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id            = aws_subnet.example1.id
    private_ipv4_address = "10.0.1.15"
  }

  subnet_mapping {
    subnet_id            = aws_subnet.example2.id
    private_ipv4_address = "10.0.2.15"
  }
}

# create autoscaling group for web tier


#create autoscaling group for app tier
