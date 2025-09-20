resource "aws_vpc" "genai_vpc" {
  cidr_block         = var.cidr_block
  enable_dns_support = "true"

  tags = {
    Name = "${var.vpc_name}"
  }
}