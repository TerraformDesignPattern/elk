// Create IAM Role
resource "aws_iam_role" "iam_role" {
  name = "${var.environment_name}-${var.unique_id}elk-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

// Create IAM Role Policy
resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  name = "${var.environment_name}-${var.unique_id}elk-ec2-policy"
  role = "${aws_iam_role.iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:DescribeLogStreams",
        "logs:GetLogEvents"
      ],
      "Resource": "${data.terraform_remote_state.vpc.flow_log_cloudwatch_log_group_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

// Create IAM Instance Profile
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name  = "${var.environment_name}-${var.unique_id}elk-instance-profile"
  roles = ["${aws_iam_role.iam_role.name}"]
}
