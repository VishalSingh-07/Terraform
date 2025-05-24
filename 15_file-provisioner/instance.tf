# Creating instance
resource "aws_instance" "terraform-first-instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-terraform.key_name
  vpc_security_group_ids = ["${aws_security_group.terraform-security-group.id}"]
  tags = {
    Name = "terraform-first-instance"
  }
  user_data = file("${path.module}/script.sh")

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host="${self.public_ip}"
  }
  
  # file, local-exec, and remote-exec
  provisioner "file" {
    source="readme.md" # terraform machine
    destination="/tmp/readme.md" # remote machine
    
  }
  provisioner "file" {
    content="this is test file" # terraform machine
    destination="/tmp/content.md" # remote machine
  }

  # Copies the testFolder folder to /tmp/testFolder
  provisioner "file" {
    source = "testFolder" # terraform machine
    destination = "/tmp/" # remote machine
  }

  provisioner "local-exec" {
    command="echo 'at create'"
  }

  provisioner "local-exec" {
    command = "echo Hello > /tmp/hello.txt"
  }
  provisioner "local-exec" {
    working_dir = "/tmp/"
    command = "echo ${self.public_ip} > myPublicIP.txt"
  }
  provisioner "local-exec" {
    interpreter = [
      "/usr/bin/python3", "-c"
    ]
    command = "print('HelloWorld')"
  }
  provisioner "local-exec" {
    command = "env > /tmp/env.txt"
    environment = {
      envname = "envvalue"
    }
  }
  provisioner "local-exec" {
    when = destroy
    command = "echo 'at destroy' "
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install net-tools",
      "ifconfig > /tmp/ifconfig.output",
      "echo 'Hello Vishal' > /tmp/test.txt"
    ]
  }
  provisioner "remote-exec" {
    script = "./testScript.sh"
  }

}

