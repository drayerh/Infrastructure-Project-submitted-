# Creating an Elastic IP for public subnet 1 NAT gateway
resource "aws_eip" "pub_sub_1" {
  vpc = true
}

# Creating NAT Gateway for pub_sub_1
resource "aws_nat_gateway" "pub_sub_1" {
  allocation_id = aws_eip.pub_sub_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = var.tags[0]
  }

  depends_on = [aws_internet_gateway.ayerhigw]
}

# Creating an Elastic IP for public subnet 2 NAT Gateway
resource "aws_eip" "pub_sub_2" {
  vpc = true
}

# Creating NAT Gateway for pub_sub_2
resource "aws_nat_gateway" "pub_sub_2" {
  allocation_id = aws_eip.pub_sub_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = var.tags[0]
  }

  depends_on = [aws_internet_gateway.ayerhigw]
}