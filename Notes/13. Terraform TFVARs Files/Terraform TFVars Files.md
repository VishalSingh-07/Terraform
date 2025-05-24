
### Terraform TFVars Files

**To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either `.tfvars `or` .tfvars.json`).**

Terraform automatically loads a number of variable definitions files if they are present:
* Files named exactly `terraform.tfvars` or `terraform.tfvars.json`.
* Any files with names ending in` .auto.tfvars` or `.auto.tfvars.json`.



##### Let's take an example

###### create a file with `.tf` extension

**main.tf**
```json
variable "age" {
    type = number
}
variable "username" {
  type = string
}

output "printUser" {
  value = "Hello, ${var.username}, your age is ${var.age}"
}
```

Create a file with **terraform.tfvars**
```jsonvars
age="22"
username = "Vishal Singh"
```

**Output:**
```sh
vishalsingh@197NOMBT3987 11_terraform-TFVARs % terraform plan

Changes to Outputs:
  + printUser = "Hello, Vishal Singh, your age is 22"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


##### TFVARs File With Different Name

If you have .tfvars file with different name then need to specify the filename explicitly like the below command

```sh
terraform apply -var-file="testing.tfvars"
```

Let's take an how can we use `tfvars` file with a different name other than **`terraform.tfvars`**

###### create a file with `.tf` extension

**main.tf**
```json
variable "age" {
    type = number
}
variable "username" {
  type = string
}

output "printUser" {
  value = "Hello, ${var.username}, your age is ${var.age}"
}
```

Create a file with **terraform.tfvars**
```
age="22"
username = "Vishal Singh"
```


Create a file with **`development.tfvars`** (you can change it as per your requirement)
```
age="19"
username = "Gulshan Kumar"
```


Now run the below command and specify the **`tfvar`** files **explicitly.**
```sh
vishalsingh@197NOMBT3987 11_terraform-TFVARs % cd Part2 
vishalsingh@197NOMBT3987 Part2 % touch development.tfvars 
vishalsingh@197NOMBT3987 Part2 % terraform plan

Changes to Outputs:
  + printUser = "Hello, Vishal Singh, your age is 22"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
vishalsingh@197NOMBT3987 Part2 % terraform plan -var-file="development.tfvars"

Changes to Outputs:
  + printUser = "Hello, Gulshan Kumar, your age is 19"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


