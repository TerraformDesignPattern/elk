// Populate User Data Template
data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh.tpl")}"
  vars {
    aws_account = "${var.aws_account}"
    aws_region = "${var.aws_region}"
    discovery_ec2_groups = "${aws_security_group.security_group.id}"
    discovery_zen_minimum_master_nodes = "${var.discovery_zen_minimum_master_nodes}"
    cluster_name = "${var.environment_name}-${var.unique_id}elk"
    flow_log_cloudwatch_log_group_arn = "${data.terraform_remote_state.vpc.flow_log_cloudwatch_log_group_arn}"
  }
}

// Launch Configuration Resource
resource "aws_launch_configuration" "launch_configuration" {
  name_prefix = "${var.environment_name}-${var.unique_id}elk-"
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.arn}"
  key_name = "${data.terraform_remote_state.account.key_pair_name}"
  image_id = "${var.image_id}"
  instance_type = "${var.launch_configuration_instance_type}"
  security_groups = ["${split(",", aws_security_group.security_group.id)}"]
  user_data = "${data.template_file.user_data.rendered}"
}
