# Creating ssh-key
resource "aws_key_pair" "key-terraform" {
  key_name   = var.key_name
  public_key = var.key
}

# Creating instance
resource "aws_instance" "terraform-first-instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-terraform.key_name
  tags = {
    Name = "terraform-first-instance"
  }
}