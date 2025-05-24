
### Pass Variable From Command Line

In last blogs we create two files. `variable.tf` and `hello-variable.tf` with the below content.

**variable.tf** contains the below content.
```json
variable username {}
```

**hello-variable.tf** with below content.
```json
output printname {
    value = "Hello, ${var.username}"
}
```

then we run **terraform plan** then terraform will ask us variable value that is **not defined**.

Now we want to supply the variable value from the command line. so that we can run terraform plan command in non-interactive node.

**Syntax:**
```sh
terraform plan -var "<VARIABLE_NAME>=<VARIABLE_VALUE>"
```


let's run the below command and see the output:
```sh
vishalsingh@197NOMBT3987 5_hello-variable % terraform plan -var "username=VishalSingh"

Changes to Outputs:
  + printname = "Hello, VishalSingh"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


