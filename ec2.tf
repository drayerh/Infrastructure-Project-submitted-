# Creating 1st EC2 instance in Public Subnet
resource "aws_instance" "web_tier_1" {
  ami                         = "ami-0648ea225c13e0729"
  instance_type               = "t2.micro"
  key_name                    = "my-ec2key-cr"
  vpc_security_group_ids      = [aws_security_group.web_tier.id]
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  user_data                   = file("data.sh")

  tags = {
    Name = var.tags[0]
  }
}

# Creating 2nd EC2 instance in Public Subnet
resource "aws_instance" "web_tier_2" {
  ami                         = "ami-0648ea225c13e0729"
  instance_type               = "t2.micro"
  key_name                    = "my-ec2key-cr"
  vpc_security_group_ids      = [aws_security_group.web_tier.id]
  subnet_id                   = aws_subnet.public_subnet_2.id
  associate_public_ip_address = true
  user_data                   = file("data.sh")

  tags = {
    Name = var.tags[0]
  }
}

# Creating 1st EC2 instance in Private Subnet 1
resource "aws_instance" "app_tier_1" {
  ami                         = "ami-0648ea225c13e0729"
  instance_type               = "t2.micro"
  key_name                    = "my-ec2key-cr"
  vpc_security_group_ids      = [aws_security_group.app_tier.id]
  subnet_id                   = aws_subnet.private_subnet_1.id
  associate_public_ip_address = false

  tags = {
    Name = var.tags[0]
  }
}

# Creating 2nd EC2 instance in Private Subnet 2
resource "aws_instance" "app_tier_2" {
  ami                         = "ami-0648ea225c13e0729"
  instance_type               = "t2.micro"
  key_name                    = "my-ec2key-cr"
  vpc_security_group_ids      = [aws_security_group.app_tier.id]
  subnet_id                   = aws_subnet.private_subnet_2.id
  associate_public_ip_address = false

  tags = {
    Name = var.tags[0]
  }
}