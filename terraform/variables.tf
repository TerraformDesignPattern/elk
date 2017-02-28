variable "aws_region" {}

variable "aws_account" {}

variable "environment_name" {}

variable "image_id" {}

variable "kibana_address" {}

variable "vpc_name" {}

variable "apply_immediately" {
  default = true
}

variable "elk_repository" {
  default = "TerraformDesignPattern/elk"
}

variable "elk_repository_branch" {
  default = "master"
}

variable "key_name" {
  default = "operations"
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
