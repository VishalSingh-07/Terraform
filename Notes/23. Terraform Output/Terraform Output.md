
### Terraform Output


The terraform output command is used to extract the value of an output variable from the state file.

```
Usage: terraform output [options] [NAME]
```

With no additional arguments, output will display all the outputs for the root module. If an output NAME is specified, only the value of that output is printed.

The command-line flags are all optional. The list of available flags are:
* **-json:** If specified, the outputs are formatted as a JSON object, with a key per output. If NAME is specified, only the output specified will be returned. This can be piped into tools such as jq for further processing.
* **-state=path:** Path to the state file. Defaults to **`terraform.tfstate.`** Ignored when remote state is used.
* **-module=module_name:** The module path which has needed output. By default this is the root path. Other modules can be specified by a period-separated list. Example: "foo" would reference the module "foo" but "foo.bar" would reference the "bar" module in the "foo" module.


###### Let's create a file with `tf` extension with below content.

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
```

**terraform.tfvars**
```json
token="your_github_token_here"
```



now run terraform init, terraform apply after that let's try with terraform output.
```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform validate
Success! The configuration is valid.
```

```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform plan
github_repository.terraform-first-repo: Refreshing state... [id=first-repo-from-terraform]

Changes to Outputs:
  + terraform-first-repo-url = "https://github.com/VishalSingh-7/first-repo-from-terraform"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform apply
github_repository.terraform-first-repo: Refreshing state... [id=first-repo-from-terraform]

Changes to Outputs:
  + terraform-first-repo-url = "https://github.com/VishalSingh-7/first-repo-from-terraform"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

terraform-first-repo-url = "https://github.com/VishalSingh-7/first-repo-from-terraform"
```

```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform output terraform-first-repo-url

"https://github.com/VishalSingh-7/first-repo-from-terraform"
```

```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform show
# github_repository.terraform-first-repo:
resource "github_repository" "terraform-first-repo" {
    allow_auto_merge            = false
    allow_merge_commit          = true
    allow_rebase_merge          = true
    allow_squash_merge          = true
    allow_update_branch         = false
    archived                    = false
    auto_init                   = true
    default_branch              = "main"
    delete_branch_on_merge      = false
    description                 = "My First Repository created using terraform."
    etag                        = "W/\"301e5ac04322372c11e0e3450452e7f8bdca5b6390a908d4788989927d6d1fc3\""
    full_name                   = "VishalSingh-7/first-repo-from-terraform"
    git_clone_url               = "git://github.com/VishalSingh-7/first-repo-from-terraform.git"
    has_discussions             = false
    has_downloads               = false
    has_issues                  = false
    has_projects                = false
    has_wiki                    = false
    homepage_url                = null
    html_url                    = "https://github.com/VishalSingh-7/first-repo-from-terraform"
    http_clone_url              = "https://github.com/VishalSingh-7/first-repo-from-terraform.git"
    id                          = "first-repo-from-terraform"
    is_template                 = false
    merge_commit_message        = "PR_TITLE"
    merge_commit_title          = "MERGE_MESSAGE"
    name                        = "first-repo-from-terraform"
    node_id                     = "R_kgDONPrADQ"
    primary_language            = null
    private                     = false
    repo_id                     = 888848397
    squash_merge_commit_message = "COMMIT_MESSAGES"
    squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
    ssh_clone_url               = "git@github.com:VishalSingh-7/first-repo-from-terraform.git"
    svn_url                     = "https://github.com/VishalSingh-7/first-repo-from-terraform"
    topics                      = []
    visibility                  = "public"
    vulnerability_alerts        = false
    web_commit_signoff_required = false

    security_and_analysis {
        secret_scanning {
            status = "enabled"
        }
        secret_scanning_push_protection {
            status = "enabled"
        }
    }
}


Outputs:

terraform-first-repo-url = "https://github.com/VishalSingh-7/first-repo-from-terraform"


