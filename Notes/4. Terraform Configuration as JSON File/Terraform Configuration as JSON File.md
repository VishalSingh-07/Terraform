
### Terraform Configuration as JSON File

**Code in the Terraform language is stored in plain text files** with the `.tf` file extension. There is also a JSON-based variant of the language that is named with the `.tf.json` file extension.

Terraform also supports an alternative syntax that is JSON-compatible. This syntax is useful when generating portions of a configuration programmatically, since existing JSON libraries can be used to prepare the generated configuration files.

let's create our **first.tf.json** file in the present working directory with the below content
```json
{
    "output":{
        "hello":{
            "value": "Hello Terraform"
        }
    }
}
```



**Run the terraform plan command and see the output.**
```sh
vishalsingh@197NOMBT3987 Terraform % cd Hello-World-In-JSON-Format 
vishalsingh@197NOMBT3987 Hello-World-In-JSON-Format % terraform plan

Changes to Outputs:
  + hello = "Hello Terraform"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


