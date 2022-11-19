# Creating Web Tier Route Table 
resource "aws_route_table" "web_tier" {
  vpc_id = aws_vpc.ayerhvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ayerhigw.id
  }

  tags = {
    Name = var.tags[0]
  }
}


# Creating Private Route table for app and db subnets in az-a
# uses nat gateway in az-a (public subnet 1)
resource "aws_route_table" "private_az_a" {
  vpc_id = aws_vpc.ayerhvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pub_sub_1.id
  }

  tags = {
    Name = var.tags[0]
  }

  depends_on = [
    aws_nat_gateway.pub_sub_1
  ]
}


# Creating Private Route table for app and db subnets in az-b
# uses nat gat in az-b (public subnet 2)
resource "aws_route_table" "private_az_b" {
  vpc_id = aws_vpc.ayerhvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pub_sub_2.id
  }

  tags = {
    Name = var.tags[0]
  }
  depends_on = [
    aws_nat_gateway.pub_sub_2
  ]
}

