
#using data source to get available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Creating 1st public subnet 
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.pub_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.tags[0]
  }
}

# Creating 2nd public subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.pub_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.tags[0]
  }
}

# Creating 1st private subnet
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet1_cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.tags[0]
  }
}

# Creating 2nd private subnet
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet2_cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.tags[0]
  }
}

# Creating 3rd private subnet
resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet3_cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.tags[0]
  }
}

# Creating 4th private subnet
resource "aws_subnet" "private_subnet_4" {
  vpc_id                  = aws_vpc.ayerhvpc.id
  cidr_block              = var.priv_subnet4_cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = var.tags[0]
  }
}
