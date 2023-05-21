resource "aws_acm_certificate" "main" {
  domain_name       = var.domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# TODO: GET YOUR DOMAIN
resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [ var.route53_validation_record[var.domain].fqdn ]
}