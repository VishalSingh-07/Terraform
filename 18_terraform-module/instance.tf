# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


module "mywebserver" {
  source        = "./modules/webserver"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  key           = file("${path.module}/id_rsa.pub")
}

output "myPublicIP" {
  value = module.mywebserver.publicIP
}

# Note: Creating your ssh-key using a commmand: ssh-keygen -t rsa -b 4096