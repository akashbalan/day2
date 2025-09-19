resource "aws_lb_target_group_attachment" "frontend_tg_attachment" {
  count = length(var.private_subnet)
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id        = element(aws_instance.frontend_ec2.*.id,count.index)
  port             = 80
}