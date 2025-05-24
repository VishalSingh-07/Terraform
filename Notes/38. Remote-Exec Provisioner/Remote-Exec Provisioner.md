
### Remote-Exec Provisioner

The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc. The remote-exec provisioner supports both `ssh` and **`winrm`** type connections.


**testScript.sh**
```sh
#!/bin/bash
echo "Hello from test Script" > /tmp/echoOutput.txt
```

**instance.tf**
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
```

**Output:**
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
aws_security_group.terraform-security-group: Creation complete after 3s [id=sg-04169fa6bcd2f940f]
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
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "echo 13.233.151.239 > myPublicIP.txt"]
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/usr/bin/python3" "-c" "print('HelloWorld')"]
aws_instance.terraform-first-instance (local-exec): HelloWorld
aws_instance.terraform-first-instance: Provisioning with 'local-exec'...
aws_instance.terraform-first-instance (local-exec): Executing: ["/bin/sh" "-c" "env > /tmp/env.txt"]
aws_instance.terraform-first-instance: Provisioning with 'remote-exec'...
aws_instance.terraform-first-instance (remote-exec): Connecting to remote host via SSH...
aws_instance.terraform-first-instance (remote-exec):   Host: 13.233.151.239
aws_instance.terraform-first-instance (remote-exec):   User: ubuntu
aws_instance.terraform-first-instance (remote-exec):   Password: false
aws_instance.terraform-first-instance (remote-exec):   Private key: true
aws_instance.terraform-first-instance (remote-exec):   Certificate: false
aws_instance.terraform-first-instance (remote-exec):   SSH Agent: true
aws_instance.terraform-first-instance (remote-exec):   Checking Host Key: false
aws_instance.terraform-first-instance (remote-exec):   Target Platform: unix
aws_instance.terraform-first-instance (remote-exec): Connected!
aws_instance.terraform-first-instance (remote-exec): /tmp/terraform_1363355027.sh: 2: ifconfig: not found
aws_instance.terraform-first-instance: Provisioning with 'remote-exec'...
aws_instance.terraform-first-instance (remote-exec): Connecting to remote host via SSH...
aws_instance.terraform-first-instance (remote-exec):   Host: 13.233.151.239
aws_instance.terraform-first-instance (remote-exec):   User: ubuntu
aws_instance.terraform-first-instance (remote-exec):   Password: false
aws_instance.terraform-first-instance (remote-exec):   Private key: true
aws_instance.terraform-first-instance (remote-exec):   Certificate: false
aws_instance.terraform-first-instance (remote-exec):   SSH Agent: true
aws_instance.terraform-first-instance (remote-exec):   Checking Host Key: false
aws_instance.terraform-first-instance (remote-exec):   Target Platform: unix
aws_instance.terraform-first-instance (remote-exec): Connected!
aws_instance.terraform-first-instance: Still creating... [30s elapsed]
aws_instance.terraform-first-instance: Creation complete after 30s [id=i-063c1c7a6957145a7]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % ssh -i id_rsa ubuntu@43.204.110.18
The authenticity of host '43.204.110.18 (43.204.110.18)' can't be established.
ED25519 key fingerprint is SHA256:dBVCU9NO7Yh7ikIFHgnXGA3by4DGsyl00uQeEQE5y70.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '43.204.110.18' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 6.8.0-1016-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Nov 18 11:40:09 UTC 2024

  System load:  0.09              Processes:             114
  Usage of /:   26.2% of 6.71GB   Users logged in:       0
  Memory usage: 24%               IPv4 address for enX0: 172.31.5.79
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

53 updates can be applied immediately.
22 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Mon Nov 18 11:37:36 2024 from 49.43.154.122
ubuntu@ip-172-31-5-79:~$ cd /tmp/
ubuntu@ip-172-31-5-79:/tmp$ ls
content.md        systemd-private-f20ba19980d24d35ac1cd8251c45ef20-ModemManager.service-g3aIKS      terraform_298049318.sh
echoOutput.txt    systemd-private-f20ba19980d24d35ac1cd8251c45ef20-chrony.service-LLYQCw            terraform_548781898.sh
ifconfig.output   systemd-private-f20ba19980d24d35ac1cd8251c45ef20-polkit.service-XhICJw            test.txt
readme.md         systemd-private-f20ba19980d24d35ac1cd8251c45ef20-systemd-logind.service-1Ld8gr    testFolder
snap-private-tmp  systemd-private-f20ba19980d24d35ac1cd8251c45ef20-systemd-resolved.service-FffWuH
ubuntu@ip-172-31-5-79:/tmp$ cat ifconfig.output
enX0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9001
        inet 172.31.5.79  netmask 255.255.240.0  broadcast 172.31.15.255
        inet6 fe80::86e:8aff:feb9:304b  prefixlen 64  scopeid 0x20<link>
        ether 0a:6e:8a:b9:30:4b  txqueuelen 1000  (Ethernet)
        RX packets 22092  bytes 31430040 (31.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1965  bytes 223151 (223.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 150  bytes 16455 (16.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 150  bytes 16455 (16.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ubuntu@ip-172-31-5-79:/tmp$ cat echoOutput.txt 
Hello from test Script
ubuntu@ip-172-31-5-79:/tmp$ cat test.txt 
Hello Vishal
ubuntu@ip-172-31-5-79:/tmp$ 
