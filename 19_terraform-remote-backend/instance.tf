terraform {
  backend "s3" {
    bucket = "vishal-tf-state-v1"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "vishal-dynamo-tf-state-v1"
  }
}



# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "terraform-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
}