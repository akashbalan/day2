resource "aws_route_table_association" "public_rt_association" {
  count = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id = aws_route_table.public_rt.id
}