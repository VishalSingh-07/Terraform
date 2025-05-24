
### Terraform Variables

So in last blog we see that we can put multiple files in a directory. and in this blogs we will use variables and print that variables. so let's start and create a file **first.tf** with below content and you can change the name of files as per your choice.

```json
variable username {}

output printname {
    value = "Hello, ${var.username}"
}
```

In the above content we declare a variable username with the help of variable block. The label after the variable keyword is a name for the variable, which must be unique among all variables in the same module.


##### Using Input Variable Values:

Within the module that declared a variable, its value can be accessed from within expressions as `var.<NAME>`, where `<NAME>` matches the label given in the declaration block (here is username)

so if we want to use a variable in terraform then we can use it using `var.variableName` and `${var.variableName}` inside string.

```sh
vishalsingh@197NOMBT3987 5_hello-variable % terraform plan
var.username
  Enter a value: Vishal Singh


Changes to Outputs:
  + printname = "Hello, Vishal Singh"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

```


> [!NOTE] Note
> Terraform will take value of username as input (we give it Vishal Singh) and it will return the output as Hello, Vishal Singh.




##### Divide Terraform files

In the previous blogs, we have seen that we can put multiple terraform configurations files in same directory. let's implement it and divide the above `first.tf` file.

let create a files `variable.tf `with the below content, in this file we will only define the variables.

**variable.tf**
```json
variable username {}
```

let create one more file **hello-variable.tf** with below content.

**hello-variable.tf**
```json
output printname{
    value = "Hello, ${var.username}"
}
```


**Output:**
```sh
vishalsingh@197NOMBT3987 5_hello-variable % terraform plan
var.username
  Enter a value: Vishal Singh


Changes to Outputs:
  + printname = "Hello, Vishal Singh"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


