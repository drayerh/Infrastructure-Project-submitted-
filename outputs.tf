# Getting the DNS of load balancer
output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.external.dns_name
}

#Getting the database connection string
output "db_connect_string" {
  description = "MySQL database connection string"
  value       = "Server=${aws_db_instance.mysql.address}; Database=mydb; Uid=${var.db_username}; Pwd=${var.db_password}"
  sensitive   = true
}
