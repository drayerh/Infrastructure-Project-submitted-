# Creating VPC
resource "aws_vpc" "ayerhvpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.tags[0]
  }
}

# Creating Internet Gateway and attaching to VPC 
resource "aws_internet_gateway" "ayerhigw" {
  vpc_id = aws_vpc.ayerhvpc.id
}