resource "aws_security_group" "frontend_allow_all" {
  name        = "${var.vpc_name}-frontend-allow-all"
  description = "Allow all Inbound traffic"
  vpc_id      = aws_vpc.genai_vpc.id

  # Ingress rule block with dynamic iteration over service ports
  dynamic "ingress" {
    for_each = var.ingress_value
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [module.frontend_alb.security_group_id] # Allow traffic from any IP
    }
  }

  # Ingress from Bastion (for SSH)
  ingress {
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    security_groups          = [aws_security_group.bastion_sg.id]
    description              = "Allow SSH from bastion"
  }

  # Egress rule block
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [module.backend_alb.security_group_id] # Allow outbound traffic to any IP
  }

  # Tags block
  tags = {
    Name = "${var.vpc_name}-allow-all"
  }
}