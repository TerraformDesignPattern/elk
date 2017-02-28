// Attach EC2 Instance to ELB
resource "aws_elb_attachment" "elb_attachment" {
  elb      = "${aws_elb.elb.id}"
  instance = "${aws_instance.instance.id}"
}

// Create Kibana External ELB
resource "aws_elb" "elb" {
  name                      = "${var.environment_name}-kibana-${var.aws_region}"
  subnets                   = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
  security_groups           = ["${aws_security_group.elb_security_group.id}"]
  cross_zone_load_balancing = true
  connection_draining       = true

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${data.terraform_remote_state.account.ssl_arn}"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "tcp:80"
    interval            = 30
  }

  tags {
    Name             = "${var.environment_name}-elk-${var.aws_region_shortname}"
    aws_account      = "${var.aws_account}"
    aws_region       = "${var.aws_region}"
    environment_name = "${var.environment_name}"
    vpc_name         = "${var.vpc_name}"
  }
}
