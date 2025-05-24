
### Terraform Validate

Once you've initialized the directory, it's good to run the validate command before you run the plan or apply. Validation will catch syntax errors, version errors, and other issues. One thing to note here is that you can't run validate before you run the init command. You have to initialize the working directory before you can run the validation.

Validate works at the level of checking your code for soundness, including loading modules and ensuring that variables are correctly named.
If you only want the basic syntax of a local file, consider using terraform fmt -write=false. If the formatter is unable to parse the file, it will throw an error.

This command **does not** check formatting (e.g. tabs vs spaces, newlines, comments etc.).

The following can be reported:
* invalid HCL syntax (e.g. missing trailing quote or equal sign)
* invalid HCL references (e.g. variable name or attribute which doesn't exist)
* same provider declared multiple times
* same module declared multiple times
* same resource declared multiple times
* invalid module name
* interpolation used in places where it's unsupported (e.g. variable, depends_on, module.source, provider)
* missing value for a variable (none of -var foo=... flag, -var-file=foo.vars flag, TF_VAR_foo environment variable, `terraform.tfvars`, or default value in the configuration)


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
```

**variables.tf**
```json
variable token{}
```

**terraform.tfvars**
```json
token="your_github_token_here"
```


now let's run terraform validate command in the same folder that we create in our previous blogs (create first resource)

```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform validate
Success! The configuration is valid.
```

```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform destroy
github_repository.terraform-first-repo: Refreshing state... [id=first-repo-from-terraform]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # github_repository.terraform-first-repo will be destroyed
  - resource "github_repository" "terraform-first-repo" {
      - allow_auto_merge            = false -> null
      - allow_merge_commit          = true -> null
      - allow_rebase_merge          = true -> null
      - allow_squash_merge          = true -> null
      - allow_update_branch         = false -> null
      - archived                    = false -> null
      - auto_init                   = true -> null
      - default_branch              = "main" -> null
      - delete_branch_on_merge      = false -> null
      - description                 = "My First Repository created using terraform." -> null
      - etag                        = "W/\"1941563e6eaed7828fbdc7c576f481a7e7cdd3c57ace75fe67bd9c503efb0c35\"" -> null
      - full_name                   = "VishalSingh-7/first-repo-from-terraform" -> null
      - git_clone_url               = "git://github.com/VishalSingh-7/first-repo-from-terraform.git" -> null
      - has_discussions             = false -> null
      - has_downloads               = false -> null
      - has_issues                  = false -> null
      - has_projects                = false -> null
      - has_wiki                    = false -> null
      - html_url                    = "https://github.com/VishalSingh-7/first-repo-from-terraform" -> null
      - http_clone_url              = "https://github.com/VishalSingh-7/first-repo-from-terraform.git" -> null
      - id                          = "first-repo-from-terraform" -> null
      - is_template                 = false -> null
      - merge_commit_message        = "PR_TITLE" -> null
      - merge_commit_title          = "MERGE_MESSAGE" -> null
      - name                        = "first-repo-from-terraform" -> null
      - node_id                     = "R_kgDONPqbOA" -> null
      - private                     = false -> null
      - repo_id                     = 888838968 -> null
      - squash_merge_commit_message = "COMMIT_MESSAGES" -> null
      - squash_merge_commit_title   = "COMMIT_OR_PR_TITLE" -> null
      - ssh_clone_url               = "git@github.com:VishalSingh-7/first-repo-from-terraform.git" -> null
      - svn_url                     = "https://github.com/VishalSingh-7/first-repo-from-terraform" -> null
      - topics                      = [] -> null
      - visibility                  = "public" -> null
      - vulnerability_alerts        = false -> null
      - web_commit_signoff_required = false -> null
        # (2 unchanged attributes hidden)

      - security_and_analysis {
          - secret_scanning {
              - status = "enabled" -> null
            }
          - secret_scanning_push_protection {
              - status = "enabled" -> null
            }
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

github_repository.terraform-first-repo: Destroying... [id=first-repo-from-terraform]
github_repository.terraform-first-repo: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.


