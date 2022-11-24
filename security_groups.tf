# Creating Security Group for external application load balancer
resource "aws_security_group" "ext_lb" {
  name        = var.ext_alb_sg
  description = "allowing inbound and outbound http traffic"
  vpc_id      = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  # All traffic to internet
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


# Creating Security Group for web tier 
resource "aws_security_group" "web_tier" {
  name        = var.web_tier_sg
  description = "allow inbound traffic from HTTP, SSH and web_lb_sg"
  vpc_id      = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from external load balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ext_lb.id]
  }

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# Creating Security Group for internal application load balancer
resource "aws_security_group" "int_lb" {
  name        = var.int_alb_sg
  description = "allow inbound traffic from web tier sg"
  vpc_id      = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from web tier security group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier.id]
  }

  # Outbound Rules
  # All traffic to web tier security group
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



# Creating Security Group for application tier
resource "aws_security_group" "app_tier" {
  name        = var.app_tier_sg
  description = "allow inbound traffic from internal alb"
  vpc_id      = aws_vpc.ayerhvpc.id

  # Inbound Rules
  # HTTP access from internal load balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.int_lb.id]
  }

  # SSH access 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Outbound Rules
  # All traffic to internal load security group
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



# Security Group for Database Tier
resource "aws_security_group" "database-sg" {
  name        = var.db_tier_sg
  description = "allow app tier to communicate with data tier"
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


