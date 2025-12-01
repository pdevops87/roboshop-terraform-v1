// to create a resource
resource "aws_instance" "instance" {
  ami           = ""
  instance_type = "t2.micro"
}

# create a dns record
resource "aws_route53_record" "record" {
  zone_id = ""
  name    = ""
  type    = "A"
  ttl     = 5
  records = [aws_instance.instance.public_ip]
}

