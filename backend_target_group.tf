resource "aws_lb_target_group" "backend_tg" {
  name     = "backend_tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.genai_vpc.id
}
