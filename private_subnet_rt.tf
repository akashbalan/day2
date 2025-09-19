resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.genai_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private_rt"
  }
}