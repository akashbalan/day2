resource "aws_instance" "frontend_ec2" {
  count                       = "${length(var.private_subnet)}"
  ami                         = var.ami_id
  key_name                    = var.key_name
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  subnet_id                   = element(aws_subnet.private_subnet.*.id, count.index)
  


  tags = {
    Name = "${var.vpc_name}frounted-ec2-${count.index}"
  }
}