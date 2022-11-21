#creating launch template for web tier  instances
resource "aws_launch_template" "web" {
  name = var.web_launch_template_name

  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }

  disable_api_stop        = true
  disable_api_termination = true

  iam_instance_profile {
    name = var.iamprofile #drayerh1
  }

  image_id = var.instance_ami #"ami-0648ea225c13e0729"

  instance_initiated_shutdown_behavior = "stop"

  instance_market_options {
    market_type = var.instance_market_type #"spot"
  }

  instance_type = var.instancetype #t2.micro

  kernel_id = "5.10"

  key_name = var.my_instance_keypair #my-ec2key-cr

    metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  vpc_security_group_ids = [aws_security_group.web_tier.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.tags[0]
    }
  }

  user_data = filebase64(IyEvYmluL2Jhc2gKCnl1bSB1cGRhdGUgLXkKeXVtIGluc3RhbGwgLXkgaHR0cGQueDg2XzY0CnN5c3RlbWN0bCBzdGFydCBodHRwZC5zZXJ2aWNlCnN5c3RlbWN0bCBlbmFibGUgaHR0cGQuc2VydmljZQplY2hvICJIZWxsbyBXb3JsZCBmcm9tICQoaG9zdG5hbWUgLWYpIiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbA)
}





#creating launch template for app tier  instances
resource "aws_launch_template" "app" {
  name = var.app_launch_template_name

  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }

  disable_api_stop        = true
  disable_api_termination = true

  iam_instance_profile {
    name = var.iamprofile #drayerh1
  }

  image_id = var.instance_ami #"ami-0648ea225c13e0729"

  instance_initiated_shutdown_behavior = "stop"

  instance_market_options {
    market_type = var.instance_market_type #"spot"
  }

  instance_type = var.instancetype

  kernel_id = "5.10"

  key_name = var.my_instance_keypair

    metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  vpc_security_group_ids = [aws_security_group.app_tier.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.tags[0]
    }
  }

  user_data = filebase64(IyEvYmluL2Jhc2gKCnl1bSB1cGRhdGUgLXkKeXVtIGluc3RhbGwgLXkgaHR0cGQueDg2XzY0CnN5c3RlbWN0bCBzdGFydCBodHRwZC5zZXJ2aWNlCnN5c3RlbWN0bCBlbmFibGUgaHR0cGQuc2VydmljZQplY2hvICJIZWxsbyBXb3JsZCBmcm9tICQoaG9zdG5hbWUgLWYpIiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbA)
}



