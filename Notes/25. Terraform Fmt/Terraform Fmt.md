

### Terraform Fmt

* The terraform fmt command is used to rewrite Terraform configuration files to a canonical format and style. This command applies a subset of the Terraform language style conventions, along with other minor adjustments for readability.
* Other Terraform commands that generate Terraform configuration will produce configuration files that conform to the style imposed by terraform fmt, so using this style in your own files will ensure consistency.
* The canonical format may change in minor ways between Terraform versions, so after upgrading Terraform we recommend to proactively run terraform fmt on your modules along with any other changes you are making to adopt the new version.

By default, fmt scans the current directory for configuration files. If the dir argument is provided then it will scan that given directory instead. If dir is a single dash (-) then fmt will read from standard input (STDIN).

Let's run **terraform fmt** command in our folder that we created in previous blogs.

```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform fmt
providers.tf
repositories.tf
terraform.tfvars
variables.tf
```




