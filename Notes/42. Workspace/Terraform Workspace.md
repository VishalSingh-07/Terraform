
### Terraform Workspace

The terraform workspace command is used to manage workspaces.


###### List:

terraform workspace list command is used to list the workspaces. by default, **default** workspace is created.The current workspace is indicated using an asterisk (*) marker.

```sh
 vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list
* default
``` 


###### Create:

- The **terraform workspace new** command is used to create a new workspace.
- This command will create a new workspace with the given name. A workspace with this name must not already exist

```sh
terraform workspace new dev
```


let's create a new workspace using below command

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace new dev

Created and switched to workspace "dev"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```


list all the created workspace

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list
  default
* dev
```

we can see that test workspace created and selected.


###### Show:

- **terraform workspace show** command will display the current workspace.

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace show
dev
```
  
so right now you are in test workspace and if you run terraform apply then tf.state will be create in that workspace.


###### Switch Workspace:

- If you want to switch workspace then you can use **terraform workspace select command.**

**Example**:

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list
  default
  dev
* prod

vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace select default
Switched to workspace "default".

vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list
* default
  dev
  prod

vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace show
default
vishalsingh@197NOMBT3987 17_terraform-workspace % 
```



###### Delete Workspace:

- If you want to delete any existing workspace then you can use terraform delete command.

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list
* default
  dev
  prod
  test

vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace delete test
Deleted workspace "test"!

vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list       
* default
  dev
  prod

vishalsingh@197NOMBT3987 17_terraform-workspace %
```

---


**dev-terraform.tfvars**
```json
region = "ap-south-1"
instance_type = "t2.nano"
access_key = "your_access_key_here"
secret_key = "your_secret_key_here"
ami_id = "ami-053b12d3152c0cc71"
```

**prod-terraform.tfvars**
```sh
region = "ap-south-1"
instance_type = "t2.small"
access_key = "your_access_key_here"
secret_key = "your_secret_key_here"
ami_id = "ami-053b12d3152c0cc71"
```


**Terminal Output:**
```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace --help
Usage: terraform [global options] workspace

  new, list, show, select and delete Terraform workspaces.

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace
```

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace select prod
Switched to workspace "prod".
```

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform workspace list 
  default
  dev
* prod

```

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform validate
Success! The configuration is valid.
```

```sh
vishalsingh@197NOMBT3987 17_terraform-workspace % terraform apply --auto-approve --var-file=prod-terraform.tfvars

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.terraform-first-instance will be created
  + resource "aws_instance" "terraform-first-instance" {
      + ami                                  = "ami-053b12d3152c0cc71"
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
      + instance_type                        = "t2.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
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

Plan: 1 to add, 0 to change, 0 to destroy.
aws_instance.terraform-first-instance: Creating...
aws_instance.terraform-first-instance: Still creating... [10s elapsed]
aws_instance.terraform-first-instance: Creation complete after 13s [id=i-0b877305feb13b779]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
vishalsingh@197NOMBT3987 17_terraform-workspace % 
```