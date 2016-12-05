// Create Auto Scaling Group Resource
resource "aws_autoscaling_group" "autoscaling_group" {
  #name = "${var.environment_name}-${var.unique_id}elk-asg"
  desired_capacity = "${var.autoscaling_group_desired_capacity}"
  health_check_type = "EC2"
  health_check_grace_period = 900
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"
  load_balancers = ["${aws_elb.external_elb.name}"]
  max_size = "${var.autoscaling_group_max_size}"
  min_elb_capacity = "${var.autoscaling_group_min_size}"
  min_size = "${var.autoscaling_group_min_size}"
  vpc_zone_identifier = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]
  wait_for_capacity_timeout = "10m"
  wait_for_elb_capacity = "${var.autoscaling_group_min_size}"
  
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = "${var.environment_name}-${var.unique_id}elk-asg"
    propagate_at_launch = true
  }

  tag {
    key = "environment"
    value = "${var.environment_name}"
    propagate_at_launch = true
  }

}
