
### Terraform Destroy

In the previous blog, we create a terraform resource we can delete it using terraform destroy command.

**Terraform Destroy:** The terraform destroy is used to destroy infrastructure governed by terraform. To check the behaviour of terraform destroy command at any time we can use terraform plan -destroy command.

Let's use terraform destroy command to delete the infra that we created in the last blog.
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
      - etag                        = "W/\"83f31fba59be506f569ce088e8efb0e98128f2e9077510a6339eec32310bce50\"" -> null
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
      - node_id                     = "R_kgDONPqI1Q" -> null
      - private                     = false -> null
      - repo_id                     = 888834261 -> null
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

```


**For the deletion of the particular resource and its dependencies -targetflag can be used**

**main.tf**
```json
provider "github"{
  token="your_github_token_here"
}

resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "My First Repository created using terraform."
  visibility = "public"
  auto_init=true

}

resource "github_repository" "terraform-second-repo" {
  name        = "second-repo-from-terraform"
  description = "My Second Repository created using terraform."
  visibility = "public"
  auto_init=true

}

```


**Example:**
```sh
vishalsingh@197NOMBT3987 13_terraform-first-resource % terraform destroy --target github_repository.terraform-second-repo 
github_repository.terraform-second-repo: Refreshing state... [id=second-repo-from-terraform]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # github_repository.terraform-second-repo will be destroyed
  - resource "github_repository" "terraform-second-repo" {
      - allow_auto_merge            = false -> null
      - allow_merge_commit          = true -> null
      - allow_rebase_merge          = true -> null
      - allow_squash_merge          = true -> null
      - allow_update_branch         = false -> null
      - archived                    = false -> null
      - auto_init                   = true -> null
      - default_branch              = "main" -> null
      - delete_branch_on_merge      = false -> null
      - description                 = "My Second Repository created using terraform." -> null
      - etag                        = "W/\"9939900c7771577439c58dc275b05e56d757e604ccd55204da705747f4155472\"" -> null
      - full_name                   = "VishalSingh-7/second-repo-from-terraform" -> null
      - git_clone_url               = "git://github.com/VishalSingh-7/second-repo-from-terraform.git" -> null
      - has_discussions             = false -> null
      - has_downloads               = false -> null
      - has_issues                  = false -> null
      - has_projects                = false -> null
      - has_wiki                    = false -> null
      - html_url                    = "https://github.com/VishalSingh-7/second-repo-from-terraform" -> null
      - http_clone_url              = "https://github.com/VishalSingh-7/second-repo-from-terraform.git" -> null
      - id                          = "second-repo-from-terraform" -> null
      - is_template                 = false -> null
      - merge_commit_message        = "PR_TITLE" -> null
      - merge_commit_title          = "MERGE_MESSAGE" -> null
      - name                        = "second-repo-from-terraform" -> null
      - node_id                     = "R_kgDONPqbRw" -> null
      - private                     = false -> null
      - repo_id                     = 888838983 -> null
      - squash_merge_commit_message = "COMMIT_MESSAGES" -> null
      - squash_merge_commit_title   = "COMMIT_OR_PR_TITLE" -> null
      - ssh_clone_url               = "git@github.com:VishalSingh-7/second-repo-from-terraform.git" -> null
      - svn_url                     = "https://github.com/VishalSingh-7/second-repo-from-terraform" -> null
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
╷
│ Warning: Resource targeting is in effect
│ 
│ You are creating a plan with the -target option, which means that the result of this plan may not represent all of the changes requested by the current
│ configuration.
│ 
│ The -target option is not for routine use, and is provided only for exceptional situations such as recovering from errors or mistakes, or when
│ Terraform specifically suggests to use it as part of an error message.
╵

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

github_repository.terraform-second-repo: Destroying... [id=second-repo-from-terraform]
github_repository.terraform-second-repo: Destruction complete after 1s
╷
│ Warning: Applied changes may be incomplete
│ 
│ The plan was created with the -target option in effect, so some changes requested in the configuration may have been ignored and the output values may
│ not be fully updated. Run the following command to verify that no other changes are pending:
│     terraform plan
│ 
│ Note that the -target option is not suitable for routine use, and is provided only for exceptional situations such as recovering from errors or
│ mistakes, or when Terraform specifically suggests to use it as part of an error message.
╵

Destroy complete! Resources: 1 destroyed.


