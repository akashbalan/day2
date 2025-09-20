## data block required


#getting certificate (ssl)
resource "aws_acm_certificate" "frontend_cert" {
  domain_name       = "niduu.info"
  validation_method = "DNS" # or "EMAIL", but DNS is recommended

  tags = {
    Name = "frontend_cert"
  }
}

#This actually creates the CNAME record ACM expects — that’s the DNS challenge.
resource "aws_route53_record" "frontend_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.frontend_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.niduu.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

#Validate certificate
resource "aws_acm_certificate_validation" "frontend_cert_validation" {
  certificate_arn         = aws_acm_certificate.frontend_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.frontend_cert_validation : record.fqdn]
}
