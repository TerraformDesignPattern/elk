// Create External ELB Security Group
resource "aws_security_group" "elb_security_group" {
  name = "${var.environment_name}-${var.unique_id}external-elk-elb-${var.aws_region}"
  description = "Security Group for ${var.environment_name}-external-elb-${var.unique_id}elk"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  // allow traffic for TCP 80
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow traffic for TCP 443
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Environment  = "${var.environment_name}"
    Name = "${var.environment_name}-${var.unique_id}external-elk-elb-${var.aws_region}"

  }
}

// Create ELK Security Group
resource "aws_security_group" "security_group" {
  name = "${var.environment_name}-${var.unique_id}elk-sg-${var.aws_region}"
  description = "Security Group for ${var.environment_name}-${var.unique_id}elk"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  // allow traffic for TCP 22
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
    cidr_blocks = ["${data.terraform_remote_state.vpc.vpc_cidr_block}"]
  }

  // allow traffic for TCP 80
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    self = true
    cidr_blocks = ["${data.terraform_remote_state.vpc.vpc_cidr_block}"]
  }

  // allow traffic for TCP 443
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    self = true
    cidr_blocks = ["${data.terraform_remote_state.vpc.vpc_cidr_block}"]
  }

  // allow traffic for TCP 6379
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    self = true
    cidr_blocks = ["${data.terraform_remote_state.vpc.vpc_cidr_block}"]
  }

  // allow traffic for TCP 9200
  ingress {
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    self = true
    cidr_blocks = ["${data.terraform_remote_state.vpc.private_subnet_cidr_blocks}"]
  }

  // allow traffic for TCP 9300
  ingress {
    from_port = 9300
    to_port = 9300
    protocol = "tcp"
    self = true
    cidr_blocks = ["${data.terraform_remote_state.vpc.private_subnet_cidr_blocks}"]
  }

  // allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Environment  = "${var.environment_name}"
    Name = "${var.environment_name}-${var.unique_id}elk-sg-${var.aws_region}"
  }
}
