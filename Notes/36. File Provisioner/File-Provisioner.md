
### File-Provisioner

The file provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource. The file provisioner supports both `ssh` and `winrm` type connections.

Let's modify **instance.tf** file to use file provisioner. and also create a **readme.md** file with any content because we are going to copy that file to remote instance.

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
}
```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % ssh -i id_rsa ubuntu@15.206.195.121
The authenticity of host '15.206.195.121 (15.206.195.121)' can't be established.
ED25519 key fingerprint is SHA256:2qagw66wSk2cTZYg147V4P5mcLyDZLTxtDBK8MZ0oxc.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '15.206.195.121' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 6.8.0-1016-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Nov 18 06:16:33 UTC 2024

  System load:  0.13              Processes:             109
  Usage of /:   26.1% of 6.71GB   Users logged in:       0
  Memory usage: 25%               IPv4 address for enX0: 172.31.2.107
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

53 updates can be applied immediately.
22 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-172-31-2-107:~$ cd /tmp/
ubuntu@ip-172-31-2-107:/tmp$ ls
content.md
readme.md
snap-private-tmp
systemd-private-bbaf6f0d97854d049aab52757b8de073-ModemManager.service-1kEfHt
systemd-private-bbaf6f0d97854d049aab52757b8de073-chrony.service-Xym6kv
systemd-private-bbaf6f0d97854d049aab52757b8de073-polkit.service-nfhgHX
systemd-private-bbaf6f0d97854d049aab52757b8de073-systemd-logind.service-2W0m1s
systemd-private-bbaf6f0d97854d049aab52757b8de073-systemd-resolved.service-HW4hHz
ubuntu@ip-172-31-2-107:/tmp$ cat content.md
this is test file
ubuntu@ip-172-31-2-107:/tmp$ cat readme.md
- This is a readme.md file

# Tasks

- ssh-key -> first-key
- assign first-key to newly created instance.

- create a security group
- assign that group to instance.

- nginx install
- /var/ww/html/index.nginx-debian.html -> Hey, Vishal Singh
ubuntu@ip-172-31-2-107:/tmp$ 
```


##### Directory Uploads
* The file provisioner is also able to upload a complete directory to the remote machine. When uploading a directory, there are a few important things you should know.
* First, when using the ssh connection type the destination directory must already exist. If you need to create it, use a remote-exec provisioner just prior to the file provisioner in order to create the directory.
* If the source is /foo (no trailing slash), and the destination is /tmp, then the contents of /foo on the local machine will be uploaded to /tmp/foo on the remote machine. The foo directory on the remote machine will be created by Terraform.
* If the source, however, is /foo/ (a trailing slash is present), and the destination is /tmp, then the contents of /foo will be uploaded directly into /tmp.
* This behavior was adopted from the standard behavior of rsync.

**Copying the directory:**
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
}
```

```sh
vishalsingh@197NOMBT3987 15_file-provisioner % ssh -i id_rsa ubuntu@13.201.22.109
The authenticity of host '13.201.22.109 (13.201.22.109)' can't be established.
ED25519 key fingerprint is SHA256:kSRuDrU212xY8qH+Au8enBZ1nFf4VBBAvuJAGyL6bEQ.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '13.201.22.109' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 6.8.0-1016-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon Nov 18 06:59:19 UTC 2024

  System load:  0.08              Processes:             109
  Usage of /:   26.1% of 6.71GB   Users logged in:       0
  Memory usage: 23%               IPv4 address for enX0: 172.31.15.112
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

53 updates can be applied immediately.
22 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-172-31-15-112:~$ cd /temp/
-bash: cd: /temp/: No such file or directory
ubuntu@ip-172-31-15-112:~$ cd /tmp/
ubuntu@ip-172-31-15-112:/tmp$ ls
content.md
readme.md
snap-private-tmp
systemd-private-46cd19e6737d4571b77d4c3ed9478ff0-ModemManager.service-GyUbmI
systemd-private-46cd19e6737d4571b77d4c3ed9478ff0-chrony.service-mo45Lw
systemd-private-46cd19e6737d4571b77d4c3ed9478ff0-polkit.service-kuP2fM
systemd-private-46cd19e6737d4571b77d4c3ed9478ff0-systemd-logind.service-NQjdIG
systemd-private-46cd19e6737d4571b77d4c3ed9478ff0-systemd-resolved.service-oeBDkf
testFolder
ubuntu@ip-172-31-15-112:/tmp$ cd testFolder/
ubuntu@ip-172-31-15-112:/tmp/testFolder$ ls
index-1.html  index-2.html  index-3.html
ubuntu@ip-172-31-15-112:/tmp/testFolder$ 
```