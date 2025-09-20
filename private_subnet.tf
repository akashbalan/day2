resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.genai_vpc.id
  cidr_block        = element(var.private_subnet, count.index)
  availability_zone = element(var.az, count.index)

  tags = {
    Name = "Main"
  }
}