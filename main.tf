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

# Creating 1st public subnet 
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.pub_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = var.tags[0]
  }
}

# Creating 2nd public subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.pub_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = var.tags[0]
  }
}

# Creating 1st private subnet
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet1_cidr
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2a"

  tags = {
    Name = var.tags[0]
  }
}

# Creating 2nd private subnet
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet2_cidr
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2b"

  tags = {
    Name = var.tags[0]
  }
}

# Creating 3rd private subnet
resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet3_cidr
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2b"

  tags = {
    Name = var.tags[0]
  }
}

# Creating 4th private subnet
resource "aws_subnet" "private_subnet_4" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet4_cidr
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2b"

  tags = {
    Name = var.tags[0]
  }
}

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

# Associating Public Subnet 1 to Web Tier Route Table
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.web_tier.id
}

# Associating Public Subnet 2 to Web Tier Route Table
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.web_tier.id
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

resource "aws_route_table" "data_az_a" {
  vpc_id = aws_vpc.ayerhvpc.id

  tags = {
    Name = var.tags[0]
  }
}

resource "aws_route_table" "data_az_b" {
  vpc_id = aws_vpc.ayerhvpc.id

  tags = {
    Name = var.tags[0]
  }
}

# Associating AZ-1 Private Subnet 1 with Private az-a Route Table 
resource "aws_route_table_association" "private_az_a" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_az_a.id
}

# Associating AZ-1 Private Subnet 3 with Private az-a Route Table 
resource "aws_route_table_association" "data_az_a" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_az_a.id
}

# Associating AZ-2 Private Subnet 2 with Private az-b Route Table 
resource "aws_route_table_association" "private_az_b" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_az_b.id
}

# Associating AZ-2 Private Subnet 4  with Private az-b Table
resource "aws_route_table_association" "data_az_b" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_az_b.id
}

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

# associating private route tables with NAT Gateways
#1st nat association
resource "aws_route" "nat_association1" {
  route_table_id         = aws_route_table.private_az_a.id
  nat_gateway_id         = aws_nat_gateway.pub_sub_1.id
  destination_cidr_block = "0.0.0.0/0"
}

#2nd nat association
resource "aws_route" "nat_association2" {
  route_table_id         = aws_route_table.private_az_b.id
  nat_gateway_id         = aws_nat_gateway.pub_sub_2.id
  destination_cidr_block = "0.0.0.0/0"
}