### List Variable

A list variable holds a list of values (for example, name of users) to be used. Each list variable specifies the order.

let see with example create a file **variable.tf** with below contents.
```json
variable users {
  type = list
}
```

let's create one more file that will access user from the users variables. (list variable.)
```json
output print{
    value = "first user is ${(var.users[1])}"
}
```


**In the above file we will accessing second element of the array. because indexing starting from the zero. let run the terraform plan and see the output.**

```sh
vishalsingh@197NOMBT3987 8_list-variable % terraform plan
var.users
  Enter a value: ["Ram", "Shyam", "Luv", "Kush"]


Changes to Outputs:
  + print = "first user is Shyam"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


Here we can see the second element of the array in the output.

we can add the default value using the below snippet
```json
variable users {
  type = list
  default = ["Ram","Shyam","Luv","Kush"]
}
```


and we can pass the list variable from the command line using below syntax.
```sh
terraform plan -var 'variablename=["valueone","valuetwo","value3"]'
```

Let's run terraform apply and see it in action.
```sh
vishalsingh@197NOMBT3987 8_list-variable % terraform plan -var 'users=["Raj", "Siraj", "Guru"]'

Changes to Outputs:
  + print = "first user is Siraj"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

