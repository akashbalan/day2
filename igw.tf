resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.genai_vpc.id

  tags = {
    Name = "ig_vpc"
  }
}