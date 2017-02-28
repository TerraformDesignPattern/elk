// Create EC2 instances
resource "aws_instance" "instance" {
  count = "${length(data.terraform_remote_state_vpc.availability_zones)}"
  ami = "${var.ami_id}"
  associate_public_ip_address = "false"
  availability_zone = "${element(data.terraform_remote_state_vpc.availability_zones.*.id, count.index)}"
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.arn}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${element(data.terraform_remote_state_vpc.private_subnet_ids.*.id, count.index)}"
  user_data            = "${data.template_file.user_data.rendered}"
  vpc_security_group_ids = ["${split(",", aws_security_group.security_group.id)}"]

  tags {
    Name = "${var.environment_name}-elk-${var.aws_region_shortname}"  
    aws_account      = "${var.aws_account}"
    aws_region       = "${var.aws_region}"
    environment_name = "${var.environment_name}"
    vpc_name         = "${var.vpc_name}"
  }
}

// Populate User Data Template
data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh.tpl")}"

  vars {
    aws_account                        = "${var.aws_account}"
    aws_region                         = "${var.aws_region}"
    cluster_name                       = "${var.environment_name}-${var.unique_id}elk"
    discovery_ec2_groups               = "${aws_security_group.security_group.id}"
    discovery_zen_minimum_master_nodes = "${var.discovery_zen_minimum_master_nodes}"
    elk_repository                     = "${var.elk_repository}"
    elk_repository_branch              = "${var.elk_repository_branch}"
  }
}

// Launch Configuration Resource
resource "aws_launch_configuration" "launch_configuration" {
  key_name             = "${data.terraform_remote_state.account.key_pair_name}"
  image_id             = "${var.image_id}"
}
