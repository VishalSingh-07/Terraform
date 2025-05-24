
### Terraform Variable Type

The type argument in a variable block allows you to restrict the type of value that will be accepted as the value for a variable. If no type constraint is set then a value of any type is accepted. type constraints are optional but its recommended by terraform to specifying them.

Type constraints are created from a mixture of type keywords and type constructors. The supported type keywords are:
* string
* number
* bool

The type constructors allow you to specify complex types such as collections:
* list
* map

If both the type and default arguments are specified, the given default value must be convertible to the specified type.

**Variable description**
Because the input variables of a module are part of its user interface, you can briefly describe the purpose of each variable using the optional description argument.

let's create a file **variable.tf** in your current working directory. with the below content.
```json
variable username {
  type = string
  default = "world"

}

variable age {
  type = number
  default = 23
}
```

and create one more file **printvariable.tf** with the below content
```json
output print{
    value = "Hello, ${var.username}, your age is ${var.age}"
}
```

you can pass the variable value from the command line using below syntax
```sh
terraform plan -var "variablename=variablevalue" -var "variable2name=varible2value"
```

now lets run terraform plan command in actions.
```sh
vishalsingh@197NOMBT3987 7_variable-types % terraform plan -var "username=Rahul" -var "age=11"

Changes to Outputs:
  + print = "Hello, Rahul, your age is 11"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

```
vishalsingh@197NOMBT3987 7_variable-types % terraform plan -var "username=Rahul" -var "age=Ram"

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Invalid value for input variable
│ 
│   on variable.tf line 5:
│    5: variable age {
│ 
│ Unsuitable value for var.age set using -var="age=...": a number is required.

