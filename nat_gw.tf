resource "aws_nat_gateway" "nat_gw" {
  count =length(var.public_subnet)
  allocation_id = element(aws_eip.nat_ip.*.id,count.index)
  subnet_id     = element(aws_subnet.public_subnet.*.id,count.index)

  tags = {
    Name = "gw NAT"
  }

  
  depends_on = [aws_internet_gateway.gw]
}