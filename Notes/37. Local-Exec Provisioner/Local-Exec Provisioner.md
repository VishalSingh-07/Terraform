
### Local-Exec Provisioner

The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource.

let's use local-exec, modify **instance.tf** file with below content.

```json
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
}
```


```sh
vishalsingh@197NOMBT3987 15_file-provisioner % terraform validate
Success! The configuration is valid.
```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.terraform-first-instance will be created
  + resource "aws_instance" "terraform-first-instance" {
      + ami                                  = "ami-0dee22c13ea7a9a67"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "key-terraform"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "terraform-first-instance"
        }
      + tags_all                             = {
          + "Name" = "terraform-first-instance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "3cce80fdd7e81af827b415a5374a7d31830123cc"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_key_pair.key-terraform will be created
  + resource "aws_key_pair" "key-terraform" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "key-terraform"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "your_ssh_key_here"
      + tags_all        = (known after apply)
    }

  # aws_security_group.terraform-security-group will be created
  + resource "aws_security_group" "terraform-security-group" {
      + arn                    = (known after apply)
      + description            = "Allow TLS inbound traffic and all outbound traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + from_port        = 0
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 3306
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 3306
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "terraform-security-group"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "terraform-security-group"
        }
      + tags_all               = {
          + "Name" = "terraform-security-group"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_key_pair.key-terraform: Creating...
aws_security_group.terraform-security-group: Creating...
aws_key_pair.key-terraform: Creation complete after 1s [id=key-terraform]
aws_security_group.terraform-security-group: Creation complete after 3s [id=sg-09c44fa429c644ec2]
aws_instance.terraform-first-instance: Creating...
aws_instance.terraform-first-instance: Still creating... [10s elapsed]
aws_instance.terraform-first-instance: Provisioning with 'file'...
aws_instance.terraform-first-instance: Still creating... [20s elapsed]
aws_instance.terraform-first-instance: Provisioning with 'file'...
aws_instance.terraform-first-instance: Provisioning with 'file'...
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo Hello > /tmp/hello.txt"]
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo 13.201.75.11 > myPublicIP.txt"]
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/usr/bin/python3" "-c" "print('HelloWorld')"]
aws_instance.terraform-first-instance (local-exec): HelloWorld
aws_instance.terraform-first-instance: Creation complete after 28s [id=i-0a2d1dd7d749178d2]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

```
vishalsingh@197NOMBT3987 15_file-provisioner % cd /tmp 
vishalsingh@197NOMBT3987 /tmp % ls
com.apple.launchd.vC7vQ2slkk    myPublicIP.txt                  tmp-mount-kANw6C
hello.txt                       powerlog
vishalsingh@197NOMBT3987 /tmp % cat hello.txt 
Hello
vishalsingh@197NOMBT3987 /tmp % cat myPublicIP.txt 
13.201.75.11
vishalsingh@197NOMBT3987 /tmp % 
```


**Environment Variables:**
```json
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
}
```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % terraform validate
Success! The configuration is valid.
```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.terraform-first-instance will be created
  + resource "aws_instance" "terraform-first-instance" {
      + ami                                  = "ami-0dee22c13ea7a9a67"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "key-terraform"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "terraform-first-instance"
        }
      + tags_all                             = {
          + "Name" = "terraform-first-instance"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "3cce80fdd7e81af827b415a5374a7d31830123cc"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_key_pair.key-terraform will be created
  + resource "aws_key_pair" "key-terraform" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "key-terraform"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "your_ssh_key_here"
      + tags_all        = (known after apply)
    }

  # aws_security_group.terraform-security-group will be created
  + resource "aws_security_group" "terraform-security-group" {
      + arn                    = (known after apply)
      + description            = "Allow TLS inbound traffic and all outbound traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + from_port        = 0
              + ipv6_cidr_blocks = [
                  + "::/0",
                ]
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 3306
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 3306
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "TLS From VPC"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "terraform-security-group"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "terraform-security-group"
        }
      + tags_all               = {
          + "Name" = "terraform-security-group"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_key_pair.key-terraform: Creating...
aws_security_group.terraform-security-group: Creating...
aws_key_pair.key-terraform: Creation complete after 1s [id=key-terraform]
aws_security_group.terraform-security-group: Creation complete after 3s [id=sg-00c26a93f747bd452]
aws_instance.terraform-first-instance: Creating...
aws_instance.terraform-first-instance: Still creating... [10s elapsed]
aws_instance.terraform-first-instance: Provisioning with 'file'...
aws_instance.terraform-first-instance: Still creating... [20s elapsed]
aws_instance.terraform-first-instance: Provisioning with 'file'...
aws_instance.terraform-first-instance: Provisioning with 'file'...
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo 'at create'"]
aws_instance.terraform-first-instance (local-exec): at create
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo Hello > /tmp/hello.txt"]
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo 13.200.235.254 > myPublicIP.txt"]
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/usr/bin/python3" "-c" "print('HelloWorld')"]
aws_instance.terraform-first-instance (local-exec): HelloWorld
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "env > /tmp/env.txt"]
aws_instance.terraform-first-instance: Creation complete after 29s [id=i-0aee54da56f9f6fb5]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % cd /tmp 
vishalsingh@197NOMBT3987 /tmp % ls
com.apple.launchd.vC7vQ2slkk    hello.txt                       powerlog
env.txt                         myPublicIP.txt                  tmp-mount-kANw6C
vishalsingh@197NOMBT3987 /tmp % cat env.txt
TERM_PROGRAM=vscode
TERM=xterm-256color
SHELL=/bin/zsh
TMPDIR=/var/folders/9l/6gjsxlqn3gn4hq1jzdjf85lc0000gp/T/
TERM_PROGRAM_VERSION=1.95.3
ZDOTDIR=/Users/vishalsingh
ORIGINAL_XDG_CURRENT_DESKTOP=undefined
MallocNanoZone=0
USER=vishalsingh
COMMAND_MODE=unix2003
SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.vC7vQ2slkk/Listeners
__CF_USER_TEXT_ENCODING=0x1F6:0x0:0x0
PATH=/Library/Frameworks/Python.framework/Versions/3.13/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/sbin
_=/usr/bin/env
USER_ZDOTDIR=/Users/vishalsingh
__CFBundleIdentifier=com.microsoft.VSCode
PWD=/Users/vishalsingh/Documents/Terraform/15_file-provisioner
envname=envvalue
LANG=en_US.UTF-8
VSCODE_GIT_ASKPASS_EXTRA_ARGS=
XPC_FLAGS=0x0
XPC_SERVICE_NAME=0
VSCODE_INJECTION=1
SHLVL=2
HOME=/Users/vishalsingh
VSCODE_GIT_ASKPASS_MAIN=/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass-main.js
LOGNAME=vishalsingh
VSCODE_GIT_IPC_HANDLE=/var/folders/9l/6gjsxlqn3gn4hq1jzdjf85lc0000gp/T/vscode-git-b4305dd8af.sock
VSCODE_GIT_ASKPASS_NODE=/Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Plugin).app/Contents/MacOS/Code Helper (Plugin)
GIT_ASKPASS=/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass.sh
COLORTERM=truecolor
```

```sh
vishalsingh@197NOMBT3987 /tmp % cd ..
vishalsingh@197NOMBT3987 / % cd ~ 
vishalsingh@197NOMBT3987 ~ % ls    
Applications            Documents               Library                 Music                   Public
Desktop                 Downloads               Movies                  Pictures                terraform.tfstate
vishalsingh@197NOMBT3987 ~ % cd Documents 
vishalsingh@197NOMBT3987 Documents % cd Terraform 
vishalsingh@197NOMBT3987 Terraform % cd 15_file-provisioner 
vishalsingh@197NOMBT3987 15_file-provisioner % terraform destroy
aws_key_pair.key-terraform: Refreshing state... [id=key-terraform]
aws_security_group.terraform-security-group: Refreshing state... [id=sg-00c26a93f747bd452]
aws_instance.terraform-first-instance: Refreshing state... [id=i-0aee54da56f9f6fb5]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.terraform-first-instance will be destroyed
  - resource "aws_instance" "terraform-first-instance" {
      - ami                                  = "ami-0dee22c13ea7a9a67" -> null
      - arn                                  = "arn:aws:ec2:ap-south-1:108333147495:instance/i-0aee54da56f9f6fb5" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "ap-south-1b" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 1 -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-0aee54da56f9f6fb5" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t2.micro" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - key_name                             = "key-terraform" -> null
      - monitoring                           = false -> null
      - placement_partition_number           = 0 -> null
      - primary_network_interface_id         = "eni-0116ac1217d91da60" -> null
      - private_dns                          = "ip-172-31-10-29.ap-south-1.compute.internal" -> null
      - private_ip                           = "172.31.10.29" -> null
      - public_dns                           = "ec2-13-200-235-254.ap-south-1.compute.amazonaws.com" -> null
      - public_ip                            = "13.200.235.254" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [
          - "terraform-security-group",
        ] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-05c15c9e536c20a9b" -> null
      - tags                                 = {
          - "Name" = "terraform-first-instance"
        } -> null
      - tags_all                             = {
          - "Name" = "terraform-first-instance"
        } -> null
      - tenancy                              = "default" -> null
      - user_data                            = "3cce80fdd7e81af827b415a5374a7d31830123cc" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-00c26a93f747bd452",
        ] -> null
        # (7 unchanged attributes hidden)

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 1 -> null
            # (1 unchanged attribute hidden)
        }

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 2 -> null
          - http_tokens                 = "required" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-00583df97b1e26fe1" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
            # (1 unchanged attribute hidden)
        }
    }

  # aws_key_pair.key-terraform will be destroyed
  - resource "aws_key_pair" "key-terraform" {
      - arn             = "arn:aws:ec2:ap-south-1:108333147495:key-pair/key-terraform" -> null
      - fingerprint     = "0a:2d:27:d1:a7:6a:f1:cb:83:9b:f4:df:a2:8e:49:3e" -> null
      - id              = "key-terraform" -> null
      - key_name        = "key-terraform" -> null
      - key_pair_id     = "key-05b456ca0ab4ce138" -> null
      - key_type        = "rsa" -> null
      - public_key      = "your_ssh_key_here" -> null
      - tags            = {} -> null
      - tags_all        = {} -> null
        # (1 unchanged attribute hidden)
    }

  # aws_security_group.terraform-security-group will be destroyed
  - resource "aws_security_group" "terraform-security-group" {
      - arn                    = "arn:aws:ec2:ap-south-1:108333147495:security-group/sg-00c26a93f747bd452" -> null
      - description            = "Allow TLS inbound traffic and all outbound traffic" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - from_port        = 0
              - ipv6_cidr_blocks = [
                  - "::/0",
                ]
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ] -> null
      - id                     = "sg-00c26a93f747bd452" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "TLS From VPC"
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "TLS From VPC"
              - from_port        = 3306
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 3306
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "TLS From VPC"
              - from_port        = 443
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 443
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "TLS From VPC"
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
        ] -> null
      - name                   = "terraform-security-group" -> null
      - owner_id               = "108333147495" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "terraform-security-group"
        } -> null
      - tags_all               = {
          - "Name" = "terraform-security-group"
        } -> null
      - vpc_id                 = "vpc-06e66f832773e7e7f" -> null
        # (1 unchanged attribute hidden)
    }

Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.terraform-first-instance: Destroying... [id=i-0aee54da56f9f6fb5]
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo 'at destroy' "]
aws_instance.terraform-first-instance (local-exec): at destroy
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 10s elapsed]
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 20s elapsed]
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 30s elapsed]
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 40s elapsed]
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 50s elapsed]
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 1m0s elapsed]
aws_instance.terraform-first-instance: Still destroying... [id=i-0aee54da56f9f6fb5, 1m10s elapsed]
aws_instance.terraform-first-instance: Destruction complete after 1m11s
aws_key_pair.key-terraform: Destroying... [id=key-terraform]
aws_security_group.terraform-security-group: Destroying... [id=sg-00c26a93f747bd452]
aws_key_pair.key-terraform: Destruction complete after 1s
aws_security_group.terraform-security-group: Destruction complete after 1s

Destroy complete! Resources: 3 destroyed.
vishalsingh@197NOMBT3987 15_file-provisioner % 

