# Creating RDS Instance
resource "aws_db_subnet_group" "default" {
  name       = var.aws_db_subnet_group_default
  subnet_ids = [aws_subnet.private_subnet_3.id, aws_subnet.private_subnet_4.id]

  tags = {
    Name = var.tags[0]
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  db_subnet_group_name   = var.aws_db_subnet_group_default
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  multi_az               = true
  db_name                = var.mydb_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
  publicly_accessible    = false
  }