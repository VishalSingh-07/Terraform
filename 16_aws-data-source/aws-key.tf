# Creating your ssh-key using a commmand: ssh-keygen -t rsa -b 4096
resource "aws_key_pair" "key-terraform" {
  key_name   = "key-terraform"
  public_key = file("${path.module}/id_rsa.pub")
}
