# Defining AWS Region
variable "aws_region" {
  description = "Region for AWS VPC"
  default     = "eu-west-2"
  type        = string
}
# Making VPC CIDR Block a variable
variable "vpc_cidr" {
  description = "vpc cidr block"
  default     = "10.0.0.0/16"
  type        = string
}
# Defining CIDR Block for 1st Public Subnet
variable "pub_subnet1_cidr" {
  description = "public subnet 1 cidr block"
  default     = "10.0.1.0/24"
  type        = string
}
# Defining CIDR Block for 2nd Public Subnet
variable "pub_subnet2_cidr" {
  description = "public subnet 2 cidr block"
  default     = "10.0.2.0/24"
  type        = string
}
# Defining CIDR Block for 1st private subnet
variable "priv_subnet1_cidr" {
  description = "private subnet"
  default     = "10.0.3.0/24"
  type        = string
}
# Defining CIDR Block for 2nd Private Subnet
variable "priv_subnet2_cidr" {
  default = "10.0.4.0/24"
  type    = string
}

# Defining CIDR Block for 3rd Private Subnet
variable "priv_subnet3_cidr" {
  default = "10.0.5.0/24"
  type    = string
}

# Defining CIDR Block for 4th Private Subnet
variable "priv_subnet4_cidr" {
  default = "10.0.6.0/24"
  type    = string

}
#making resource tags a variable
variable "tags" {
  description = "aws resource tags according to department"
  type        = list(string)
  default     = ["prod", "test", "dev"]
}



#### Defining Variables for RDS Database

#Making Database username sensitive
variable "db_username" {
  description = "RDS administrator username"
  type        = string
  sensitive   = true
}

#Making Database password sensitive
variable "db_password" {
  description = "RDS administrator password"
  type        = string
  sensitive   = true
}

#Making Database name a variable
variable "mydb_name" {
  description = "RDS database name"
  type        = string
  default  = "mysql-database-3tier"
}

#Making my ip address for SSH access sensitive
variable "my_ip" {
  description = "my ip address for SSH access"
  type        = string
  sensitive   = true
}

#Making db subnet group name a variable
variable "aws_db_subnet_group_default" {
  description = "my default db subnet group"
  type        = string
  default     = "my subnet group"
}





#Defining variables and data for load balancer
variable "lb_arn" {
  type    = string
  default = ""
}

variable "lb_name" {
  type    = string
  default = ""
}

data "aws_lb" "test" {
  arn  = var.lb_arn
  name = var.lb_name
}




#Defining variables and data for load balancer listener
variable "listener_arn" {
  type = string
}

data "aws_lb_listener" "listener" {
  arn = var.listener_arn
}

# get listener from load_balancer_arn and port

data "aws_lb" "selected" {
  name = "default-public"
}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = data.aws_lb.selected.arn
  port              = 443
}