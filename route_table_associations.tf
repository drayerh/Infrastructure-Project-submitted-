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

# Associating AZ-1 Private Subnet 1 with Private az-a Route Table 
resource "aws_route_table_association" "private_az_a_app" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_az_a.id
}

# Associating AZ-1 Private Subnet 3 with Private az-a Route Table 
resource "aws_route_table_association" "private_az_a_data" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_az_a.id
}

# Associating AZ-2 Private Subnet 2 with Private az-b Route Table 
resource "aws_route_table_association" "private_az_b_app" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_az_b.id
}

# Associating AZ-2 Private Subnet 4  with Private az-b Table
resource "aws_route_table_association" "private_az_b_data" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_az_b.id
}