resource "aws_route_table_association" "private_rt_association" {
  count = length(var.private_subnet)
  subnet_id      = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id = aws_route_table.private_rt.id
}