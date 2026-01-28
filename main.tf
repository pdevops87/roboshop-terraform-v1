// to create a resource
resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  vpc_security_group_ids = [data.aws_security_group.sg]
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
  for_each      = var.components
  depends_on = [
  aws_instance.instance,
  aws_route53_record.record
  ]
  triggers = {
    timestamp = timestamp()
    instance_id = aws_instance.instance[each.key].id
  }

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
      "ansible-pull -i localhost, -U https://github.com/pdevops87/roboshop-ansible-v4 roboshop.yaml -e component=${each.key} -e env=${var.env}"
    ]
  }
}


# RHEL-9-DevOps-Practice
