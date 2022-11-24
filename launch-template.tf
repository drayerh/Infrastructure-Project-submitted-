#creating launch template for web tier  instances
resource "aws_launch_template" "web" {
  name = var.web_launch_template_name
  /*
  cpu_options {
    core_count       = var.web_cpu_cc
    threads_per_core = var.web_cpu_tpc
  }*/

  image_id = var.instance_ami

  /*instance_initiated_shutdown_behavior = var.init_shutdown_behaviour*/

  instance_market_options {
    market_type = var.instance_market_type
  }

  instance_type = var.instance_type

  key_name = var.my_instance_keypair
  /*
    metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  */

  monitoring {
    enabled = var.monitoring
  }

  network_interfaces {
    associate_public_ip_address = var.assoc_public_ip
    security_groups             = [aws_security_group.web_tier.id]
  }

  tag_specifications {
    resource_type = var.tag_spec_res_type

    tags = {
      Name = var.tags[0]
    }
  }

  user_data = filebase64("${"install_apache.sh"}")
}







#creating launch template for app tier  instances
resource "aws_launch_template" "app" {
  name = var.app_launch_template_name
  /*
  cpu_options {
    core_count       = var.app_cpu_cc
    threads_per_core = var.app_cpu_tpc
  }*/

  image_id = var.instance_ami

  /*instance_initiated_shutdown_behavior = var.init_shutdown_behaviour
*/
  instance_market_options {
    market_type = var.instance_market_type
  }

  instance_type = var.instance_type

  key_name = var.my_instance_keypair
  /*
    metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  */

  monitoring {
    enabled = var.monitoring
  }

  network_interfaces {
    associate_public_ip_address = var.assoc_public_ip
    security_groups             = [aws_security_group.app_tier.id]
  }

  tag_specifications {
    resource_type = var.tag_spec_res_type

    tags = {
      Name = var.tags[0]
    }
  }

  user_data = filebase64("${"install_apache.sh"}")
}





