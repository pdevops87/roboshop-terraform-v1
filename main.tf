// to create a resource
resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  tags = {
    Name = each.key
  }
}
# create a dns record
resource "aws_route53_record" "record" {
  for_each         =    var.components
  zone_id          =    var.zone_id
  name             =    "${each.key}-${var.env}"
  type             =    "A"
  ttl              =     5
  records          =   [aws_instance.instance[each.key].private_ip]
}

resource "null_resource" "provisioner" {
  depends_on = [
  aws_instance.instance,
  aws_route53_record.record
  ]
  triggers = {
    timestamp = timestamp()

  }
  for_each      = var.components

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = aws_instance.instance[each.key].private_ip
    }
    inline = [
      "sudo dnf install python3.11-pip -y",
      "sudo pip3.11 install ansible",
      "ansible-pull -i localhost, -U https://github.com/pdevops87/roboshop-ansible-v4 roboshop.yaml -e component=${each.key} -e env=dev"
    ]
  }
#   provisioner "remote-exec" {
#     inline = ["echo 'Hello terraform'"]
#   }

}


# RHEL-9-DevOps-Practice
