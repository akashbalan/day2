resource "aws_instance" "bastion_ec2" {
  ami           = var.ami_id# Ubuntu AMI ID for your region
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet[0].id  # put in first public subnet
  key_name      = var.key_name            # same key as backend/frontend

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-ec2"
  }
}

# Security group for Bastion
resource "aws_security_group" "bastion_sg" {
  name   = "bastion-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # only your IP, not 0.0.0.0/0 for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"] # allow it to talk to private EC2s
  }
}
