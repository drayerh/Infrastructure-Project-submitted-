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

#defining security group variables
variable "ext_alb_sg" {
  type    = string
  default = "ext-alb-sg"
}

#defining web tier sg
variable "web_tier_sg" {
  type    = string
  default = "web-tier-sg"
}

#defining int alb-sg
variable "int_alb_sg" {
  type    = string
  default = "int-alb-sg"
}
#defining app tier sg
variable "app_tier_sg" {
  type    = string
  default = "app-tier-sg"
}
#defining db tier sg
variable "db_tier_sg" {
  type    = string
  default = "db-tier-sg"
}

#Defining variables for load balancers
variable "lb_type" {
  type    = list(string)
  default = ["application", "network", "classic"]
}
variable "ext_lb_arn" {
  type    = string
  default = "aws_lb.eternal.id"
}

variable "ext_lb_name" {
  type    = string
  default = "ayerhvpc-external-lb"
}

variable "int_lb_arn" {
  type    = string
  default = "aws_lb.internal.id"
}

variable "int_lb_name" {
  type    = string
  default = "ayerhvpc-internal-lb"
}

#Defining variables for autoscaling security_groups
#Web Tier ASG

#web asg desired capacity
variable "asg_web_dc" {
  type    = number
  default = 4
}

#web asg maximum size
variable "asg_web_max" {
  type    = number
  default = 4
}
#web asg minimum size
variable "asg_web_min" {
  type    = number
  default = 4
}


#App Tier ASG

#app asg desired capacity
variable "asg_app_dc" {
  type    = number
  default = 4
}

#web asg maximum size
variable "asg_app_max" {
  type    = number
  default = 4
}
#web asg minimum size
variable "asg_app_min" {
  type    = number
  default = 4
}


#Defining variables for launch templates 

#launch template name
variable "web_launch_template_name" {
  type    = string
  default = "aws_launch_template.web.id"
}

#launch template cpu options
#core count
variable "web_cpu_cc" {
  type    = number
  default = 1
}
#threads per core
variable "web_cpu_tpc" {
  type    = number
  default = 2
}

#ami-id
variable "instance_ami" {
  type    = string
  default = "ami-0648ea225c13e0729"
}

#instance_initiated_shutdown_behaviour
variable "init_shutdown_behaviour" {
  type    = string
  default = "stop"
}

#instance_market_type
variable "instance_market_type" {
  type    = string
  default = "spot"
}

#instance_type
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

#instance key pair
variable "my_instance_keypair" {
  type    = string
  default = "my-ec2key-cr"
}

#enabling monitoring
variable "monitoring" {
  type    = bool
  default = "true"
}

#network interfaces
variable "assoc_public_ip" {
  type    = bool
  default = "true"
}

#tag specification resource type
variable "tag_spec_res_type" {
  type    = string
  default = "instance"
}

#launch template name
variable "app_launch_template_name" {
  type    = string
  default = "aws_launch_template.app.id"
}

#launch template cpu options
#core count
variable "app_cpu_cc" {
  type    = number
  default = 1
}
#threads per core
variable "app_cpu_tpc" {
  type    = number
  default = 2
}




## Defining Variables for RDS Database

#Making db subnet group name a variable
variable "aws_db_subnet_group_default" {
  description = "my default db subnet group"
  type        = string
  default     = "my subnet group"
}

#DB engine name
variable "my_engine" {
  description = "my database engine"
  type        = string
  default     = "mysql"
}

#DB engine version
variable "my_engine_version" {
  description = "my database engine version"
  type        = string
  default     = "8.0.28"
}

#DB instance class
variable "instance_class" {
  description = "my database instance class"
  type        = string
  default     = "db.t2.micro"
}


# Database username 
variable "db_username" {
  description = "RDS administrator username"
  type        = string
  default   = "drayerh"
}

#Database password 
variable "db_password" {
  description = "RDS administrator password"
  type        = string
  default  = "insecurepassword"
}








