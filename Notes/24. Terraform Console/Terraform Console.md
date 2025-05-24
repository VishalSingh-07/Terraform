
### Terraform Console
* The terraform console command provides an interactive console for evaluating expressions.
* This command provides an interactive command-line console for evaluating and experimenting with expressions.
* This is useful for testing interpolations before using them in configurations, and for interacting with any values currently saved in state.
* If the current state is empty or has not yet been created, the console can be used to experiment with the expression syntax and built-in functions.
* The dir argument specifies the directory of the root module to use. If a path is not specified, the current working directory is used.
* The supported options are:
    * **-state=path:** Path to a local state file. Expressions will be evaluated using values from this state file. If not specified, the state associated with the current workspace is used.
* You can close the console with the exit command or by pressing Control-C or Control-D.


##### Let's create a file with `tf` extension with below content.

**providers.tf**
```json
provider "github"{
  token="${var.token}"
}
```

**repositories.tf**
```json
resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "My First Repository created using terraform."
  visibility = "public"
  auto_init=true

}

output "terraform-first-repo-url"{
  value=github_repository.terraform-first-repo.html_url
}
```


**variables.tf**
```json
variable token{}
variable username{
    default = "Vishal Singh"
}
variable age {
  default = 22
}
variable city{
    default = "Agra"
}
```

**terraform.tfvars**
```json
token="your_github_token_here"
```


**Output:**
```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform console
> var.username
"Vishal Singh"
> var.age
22
> var.city
"Agra"
> github_repository.terraform-first-repo.html_url
"https://github.com/VishalSingh-7/first-repo-from-terraform"
> github_repository.terraform-first-repo.ssh_clone_url
"git@github.com:VishalSingh-7/first-repo-from-terraform.git"
> github_repository.terraform-first-repo.full_name
"VishalSingh-7/first-repo-from-terraform"
> exit
```


