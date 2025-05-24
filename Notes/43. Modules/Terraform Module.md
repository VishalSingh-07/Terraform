
### Terraform Module

Up to this point, we've been configuring Terraform by editing Terraform configurations directly. As our infrastructure grows, this practice has a few key problems: a lack of organization, a lack of reusability, and difficulties in management for teams.

**Modules** in Terraform are self-contained packages of Terraform configurations that are managed as a group. Modules are used to create reusable components, improve organization, and to treat pieces of infrastructure as a black box.

A _module_ is a container for multiple resources that are used together. Modules can be used to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

The .tf files in your working directory when you run terraform plan or terraform apply together form the _root_ module. That module may call other modules and connect them together by passing output values from one to input values of another.

#### Module structure

Re-usable modules are defined using all of the same configuration language concepts we use in root modules. Most commonly, modules use:

- Input variables to accept values from the calling module.
- Output values to return results to the calling module, which it can then use to populate arguments elsewhere.
- Resources to define one or more infrastructure objects that the module will manage.

To define a module, create a new directory for it and place one or more .tf files inside just as you would do for a root module. Terraform can load modules either from local relative paths or from remote repositories; if a module will be re-used by lots of configurations you may wish to place it in its own version control repository.

Modules can also call other modules using a module block, but we recommend keeping the module tree relatively flat and using [module composition](http://man.hubwiz.com/docset/Terraform.docset/Contents/Resources/Documents/docs/modules/composition.html) as an alternative to a deeply-nested tree of modules, because this makes the individual modules easier to re-use in different combinations.

#### When to write a module

In principle, any combination of resources and other constructs can be factored out into a module, but over-using modules can make your overall Terraform configuration harder to understand and maintain, so we recommend moderation.

A good module should raise the level of abstraction by describing a new concept in your architecture that is constructed from resource types offered by providers.

The module installer supports installation from a number of different source types, as listed below.
1. Local paths
2. Terraform Registry
3. GitHub
4. Bitbucket
5. Generic Git, Mercurial repositories
6. HTTP URLs
7. S3 buckets
8. GCS buckets
9. Modules in Package Sub-directories

URL requires of above sources in module source parameter.

Now let's create a module and use them. create a **modules/webserver** folder in your current working directory.

Now create a file **/modules/webserver/resource.tf** with below content.

```json
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
```

Create a file **/modules/webserver/variables.tf** with below content.

```json
variable "instance_type" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "key" {
  type = string
}
variable "key_name" {
  type = string
}
```

Create a file **/modules/webserver/output.tf** with the below content.

```json
output "publicIP" {
  value = aws_instance.terraform-first-instance.public_ip
}
```


Now use this module, let's create a file in your current directory.

Create **variables.tf** with the below content.

```json
variable "region" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "key_name" {
  type = string
}
```

create a file named **instance.tf** with the below content.

```json
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
```

create a file named **terraform.tfvars** with the below contents

```json
region        = "ap-south-1"
instance_type = "t2.micro"
access_key    = "your_access_key_here"
secret_key    = "your_secret_key_here"
ami_id        = "ami-0dee22c13ea7a9a67"
key_name      = "key-terraform"
```

now let's run terraform init, and terraform apply and check instance is created in your AWS account.


```sh
vishalsingh@197NOMBT3987 18_terraform-module % terraform validate
Success! The configuration is valid.
```

```sh
vishalsingh@197NOMBT3987 18_terraform-module % terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.mywebserver.aws_instance.terraform-first-instance will be created
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
      + user_data                            = (known after apply)
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

  # module.mywebserver.aws_key_pair.key-terraform will be created
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

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + myPublicIP = (known after apply)

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
now.
```

```sh
vishalsingh@197NOMBT3987 18_terraform-module % terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.mywebserver.aws_instance.terraform-first-instance will be created
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
      + user_data                            = (known after apply)
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

  # module.mywebserver.aws_key_pair.key-terraform will be created
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

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + myPublicIP = (known after apply)
module.mywebserver.aws_key_pair.key-terraform: Creating...
module.mywebserver.aws_key_pair.key-terraform: Creation complete after 1s [id=key-terraform]
module.mywebserver.aws_instance.terraform-first-instance: Creating...
module.mywebserver.aws_instance.terraform-first-instance: Still creating... [10s elapsed]
module.mywebserver.aws_instance.terraform-first-instance: Still creating... [20s elapsed]
module.mywebserver.aws_instance.terraform-first-instance: Still creating... [30s elapsed]
module.mywebserver.aws_instance.terraform-first-instance: Creation complete after 32s [id=i-0d5c82a62c178bff3]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

myPublicIP = "13.233.118.228"
vishalsingh@197NOMBT3987 18_terraform-module % 
```


