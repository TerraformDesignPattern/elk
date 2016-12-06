variable "aws_region" {}
variable "aws_account" {}
variable "environment_name" {}
variable "image_id" {}
variable "kibana_address" {}
variable "vpc_name" {}

variable "apply_immediately" {
  default = true
}

variable "autoscaling_group_desired_capacity" {
  default = "3"
}

variable "autoscaling_group_min_size" {
  default = "1"
}

variable "autoscaling_group_max_size" {
  default = "3"
}

variable "discovery_zen_minimum_master_nodes" {
  default = "2"
}

variable "elk_repository" {
  default = "TerraformDesignPattern/elk"
}

variable "elk_repository_branch" {
  default = "master"
}

variable "launch_configuration_instance_type" {
  default = "t2.medium"
}

variable "node_type" {
  default = "cache.t2.micro"
}

variable "unique_id" {
  default = ""
}

