resource "null_resource" "cluster" {
  count = length(var.private_subnet)

  provisioner "file" {
    source      = "backend-user-data.sh"
    destination = "/tmp/backend-user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terr.pem")

      # The target is the private EC2
      host = element(aws_instance.backend_ec2.*.private_ip, count.index)

      # Bastion (jump host)
      bastion_host        = aws_instance.bastion_ec2.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file("terr.pem")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 700 /tmp/backend-user-data.sh",
      "sudo /tmp/backend-user-data.sh",
      "sudo apt update",
      "sudo apt install jo unzip -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terr.pem")

      # Target private EC2
      host = element(aws_instance.backend_ec2.*.private_ip, count.index)

      # Bastion
      bastion_host        = aws_instance.bastion_ec2.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file("terr.pem")
    }
  }
}
