# Creating an External LoadBalancer 
resource "aws_lb" "external" {
  name            = "ayerhvpc-external-lb"
  internal        = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.ext_lb.id]
  subnets         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Name = var.tags[0]
  }
  } 


# Creating an Internal Load Balancer
resource "aws_lb" "internal" {
  name                       = "ayerhvpc-internal-alb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.int_lb.id]
  subnets                    = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  enable_deletion_protection = false
  
  tags = {
    Name = var.tags[0]
  }
}