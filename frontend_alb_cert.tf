resource "aws_acm_certificate" "frontend_cert" {
  domain_name       = "niduu.info"
  validation_method = "DNS" # or "EMAIL", but DNS is recommended

  tags = {
    Name = "example-cert"
  }
}