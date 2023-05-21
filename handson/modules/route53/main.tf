data "aws_route53_zone" "main" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "validation" {
  depends_on = [var.aws_acm_certificate]
  zone_id    = data.aws_route53_zone.main.zone_id
  ttl = 60

for_each = {
  for dvo in var.aws_acm_certificate.domain_validation_options : dvo.domain_name => {
    name = dvo.resource_record_name
    type = dvo.resource_record_type
    records = [dvo.resource_record_value]
  }
}
  name = each.value.name
  type = each.value.type
  records = each.value.records
}

resource "aws_route53_record" "main" {
  type = "A"
  name = var.domain
  zone_id = data.aws_route53_zone.main.zone_id
  alias {
    name = var.aws_alb_main_dns_name
    zone_id = var.aws_alb_main_zone_id
    evaluate_target_health = true
  }
}