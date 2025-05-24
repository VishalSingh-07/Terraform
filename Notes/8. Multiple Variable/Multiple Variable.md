### Multiple Variable

We can defined any number of variable in same way. let see it with example so create **variable.tf** file with below content.

How to set default value to the variable:
```json
variable username{
    default = "World"
}
```


**variable.tf** contains the below content.
```json
variable username{}
variable age {}
```

**output-variable.tf** with below content.
```json
output print{
    value = "Hello, ${var.username}, your age is ${var.age}"
}
```

here are declaring two variable username and age in `variable.tf`and printing them in `output-variable.tf`

let's run terraform plan command and see the output
```sh
vishalsingh@197NOMBT3987 6_multiple-variable % terraform plan
var.age
  Enter a value: 22

var.username
  Enter a value: Vishal Singh


Changes to Outputs:
  + print = "Hello, Vishal Singh, your age is 22"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


we can pass the multiple variable from command line using below syntax.
```sh
$terraform plan -var "<VARIABLE_1_NAME>=<VARIABLE_1_VALUE>" -var "<VARIABLE_2_NAME>=<VARIABLE_2_VALUE>"
```


**Let's see it in actions.**
```sh
vishalsingh@197NOMBT3987 6_multiple-variable % terraform plan -var "username=VishalSingh" -var "age=22"

Changes to Outputs:
  + print = "Hello, VishalSingh, your age is 22"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

