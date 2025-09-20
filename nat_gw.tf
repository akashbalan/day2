resource "aws_nat_gateway" "nat_gw" {
  #count         = length(var.public_subnet)
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "gw NAT"
  }


  depends_on = [aws_internet_gateway.gw]
}