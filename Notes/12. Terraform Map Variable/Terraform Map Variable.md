
### Terraform Map Variable

A map value is a lookup table from string keys to string values. This is useful for selecting a value based on some other provided value.

A common use of maps is to create a table of machine images per region, as follows:
```json
variable "images" {
  type    = "map"
  default = {
    "us-east-1" = "image-1234"
    "us-west-2" = "image-4567"
  }
}
```

Lets take an simple example of terraform map

###### create a file with **`.tf`** extension.

**variable.tf**
```json
variable usersAge {
  type = map
  default = {
    ram=20
    shyam=21
  }
}
```

**main.tf**
```json
output printUsersAge{
    value = "Hi, my name is ram and my age is ${lookup(var.usersAge,"ram")}"
}
```

now let's run terraform apply and see the output
```sh
vishalsingh@197NOMBT3987 10_map-variable % terraform plan

Changes to Outputs:
  + printUsersAge = "Hi, my name is ram and my age is 20"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


###### How to Read values Dynamically from Map Variable

**Lets create a file**

**variable.tf**
```json
variable usersAge {
  type = map
  default = {
    ram=20
    shyam=21
  }
}

variable username {
  type = string
}
```

**main.tf**
```json
output printUsersAge{
    value = "Hi, my name is ${var.username} and my age is ${lookup(var.usersAge,var.username)}"
}
```

**Outputs:**
```sh
vishalsingh@197NOMBT3987 dynamically % terraform plan
var.username
  Enter a value: ram


Changes to Outputs:
  + printUsersAge = "Hi, my name is ram and my age is 20"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


vishalsingh@197NOMBT3987 dynamically % terraform plan
var.username
  Enter a value: shyam


Changes to Outputs:
  + printUsersAge = "Hi, my name is shyam and my age is 21"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

vishalsingh@197NOMBT3987 dynamically % terraform plan -var "username=shyam"

Changes to Outputs:
  + printUsersAge = "Hi, my name is shyam and my age is 21"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


**How to pass Map Variable From Command line**
```sh
vishalsingh@197NOMBT3987 dynamically % terraform plan -var username="raj" -var usersAge="{"raj"=19, "vishal"=22}" 

Changes to Outputs:
  + printUsersAge = "Hi, my name is raj and my age is 19"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


