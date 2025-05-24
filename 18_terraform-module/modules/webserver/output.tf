output "publicIP" {
  value = aws_instance.terraform-first-instance.public_ip
}
