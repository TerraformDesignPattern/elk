output "autoscaling_group_id" {
  value = "${aws_autoscaling_group.autoscaling_group.id}"
}

output "launch_configuration_id" {
  value = "${aws_launch_configuration.launch_configuration.id}"
}

output "ec2_security_group_id" {
  value = "${aws_security_group.ec2_security_group.id}"
}
