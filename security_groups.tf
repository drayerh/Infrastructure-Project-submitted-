
# Creating Security Group for web tier 
resource "aws_security_group" "web_tier" {
  vpc_id = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from external load balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.ext_lb.id]
  }

  # HTTPS access from external load balancer
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.ext_lb.id]
  }

  # SSH traffic from external load balancer
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.ext_lb.id]
  }

  # allow http from external alb
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.ext_lb.id]
  }


  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tags[0]
  }
}



# Creating Security Group for application tier
resource "aws_security_group" "app_tier" {
  vpc_id = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from web tier
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "https"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  # SSH access from web tier
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }
  
  # MY SQL traffic from web tier
  ingress {
    description     = "Allow traffic from web tier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  # Outbound Rules
  # All traffic to web tier
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.web_tier.id]
  }

  tags = {
    Name = var.tags[0]
  }
}



# Security Group for Database Tier
resource "aws_security_group" "database-sg" {
  name        = "Database SG"
  description = "Allow inbound traffic from app tier"
  vpc_id      = aws_vpc.ayerhvpc.id

  # Inbound
  ingress {
    description     = "Allow SQL from app tier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_tier.id]
  }
  # Outbound
  egress {
    from_port       = 32768
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.app_tier.id]
  }

  tags = {
    Name = var.tags[0]
  }
}


##  CREATING SECURITY GROUPS FOR ELASTIC LOAD BALANCERS


# Creating Security Group for external application load balancer
resource "aws_security_group" "ext_lb" {
  vpc_id = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from internet
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "https"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # SSH access from web tier
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }
  
  # Outbound Rules
  # All traffic from web tier
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.web_tier.id]
  }

  tags = {
    Name = var.tags[0]
  }
}



# Creating Security Group for internal application load balancer
resource "aws_security_group" "int_lb" {
  vpc_id = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from web tier security group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "http"
    security_groups = [aws_security_group.web_tier.id]
  }
  

  # SSH access from web tier security group
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }
  
  # Outbound Rules
  # All traffic from web tier
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.app_tier.id]
  }

  tags = {
    Name = var.tags[0]
  }
}
