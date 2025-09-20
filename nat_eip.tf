resource "aws_eip" "nat_ip" {
  #count = length(var.public_subnet)



  tags = {
    Name = "NAT EIP "
  }
}