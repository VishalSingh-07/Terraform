# Creating instance
resource "aws_instance" "terraform-first-instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  tags = {
    Name = "terraform-first-instance"
  }
}

