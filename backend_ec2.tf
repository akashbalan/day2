resource "aws_instance" "backend_ec2" {
  count                  = length(var.private_subnet)
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.backend_allow_all.id}"]
  subnet_id              = element(aws_subnet.private_subnet.*.id, count.index)



  tags = {
    Name = "${var.vpc_name}backend-ec2-${count.index}"
  }
}