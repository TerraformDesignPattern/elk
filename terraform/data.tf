data "terraform_remote_state" "account" {
  backend = "s3"
  config {
    bucket = "${var.aws_account}"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "${var.aws_account}"
    key = "${var.aws_region}/${var.vpc_name}/terraform.tfstate"
    region = "us-east-1"
  }
}
