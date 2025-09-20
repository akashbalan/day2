module "frontend_alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "frontendalb"
  vpc_id  = aws_vpc.genai_vpc.id
  subnets = aws_subnet.public_subnet.*.id

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  # security_group_egress_rules = {
  #   allow_to_frontend_ec2 = {
  #     from_port                    = "80"
  #     to_port                      = "80"
  #     ip_protocol                  = "tcp"
  #     referenced_security_group_id = aws_security_group.frontend_allow_all.id
  #     description                  = "Allow ALB to forward traffic to frontend EC2s"
  #   }
  # }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "10.0.0.0/16"
    }
  }


  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    ex-https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = aws_acm_certificate_validation.frontend_cert_validation.certificate_arn

      forward = {
        target_group_arn = aws_lb_target_group.frontend_tg.arn
      }
    }
  }


  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}

resource "aws_route53_record" "frontend_alias" {
  zone_id = data.aws_route53_zone.niduu.zone_id
  name    = "app.niduu.info"
  type    = "A"

  alias {
    name                   = module.frontend_alb.dns_name
    zone_id                = module.frontend_alb.zone_id
    evaluate_target_health = true
  }
}