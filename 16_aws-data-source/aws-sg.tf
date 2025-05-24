# Creating Security Group
resource "aws_security_group" "terraform-security-group" {
  name        = "terraform-security-group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS From VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "terraform-security-group"
  }
}
