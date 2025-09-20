resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontendtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.genai_vpc.id
}
