
### Terraform Environment Variable

Terraform searches the environment of its own process for environment variables named TF_VAR_ followed by the name of a declared variable.

This can be useful when running Terraform in automation, or when running a sequence of Terraform commands in succession with the same variables.

On operating systems where environment variable names are case-sensitive, Terraform matches the variable name exactly as given in configuration, and so the required environment variable name will usually have a mix of upper and lower case letters.


**Let's take an example create a terraform file**

```json
variable "username" {
  type = string
}

output "printUser" {
  value = "Hello, ${var.username}"
}
```


now set the value of username variable in the environment using the below command

```sh
export TF_VAR_username=Raj
```

now run terraform plan command and see the output.
```sh
vishalsingh@197NOMBT3987 12_environment-variable % echo $username

vishalsingh@197NOMBT3987 12_environment-variable % export username="Raj"
vishalsingh@197NOMBT3987 12_environment-variable % echo $username       
Raj
vishalsingh@197NOMBT3987 12_environment-variable % terraform plan       
var.username
  Enter a value: Ankit


Changes to Outputs:
  + printUser = "Hello, Ankit"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

```sh
vishalsingh@197NOMBT3987 12_environment-variable % export TF_VAR_username="Raj"
vishalsingh@197NOMBT3987 12_environment-variable % terraform plan              

Changes to Outputs:
  + printUser = "Hello, Raj"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


