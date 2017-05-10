// Create ELB DNS Alias
resource "aws_route53_record" "external_elb_route53_record" {
  zone_id = "${data.terraform_remote_state.account.route53_zone_id}"
  name    = "${var.kibana_address}.${data.terraform_remote_state.account.domain_name}."
  type    = "A"

  alias {
    name                   = "${aws_elb.external_elb.dns_name}"
    zone_id                = "${aws_elb.external_elb.zone_id}"
    evaluate_target_health = false
  }
}
