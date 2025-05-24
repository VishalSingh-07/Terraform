resource "github_repository" "terraform-first-repo" {
  name        = "first-repo-from-terraform"
  description = "My First Repository created using terraform."
  visibility  = "public"
  auto_init   = true

}

output "terraform-first-repo-url" {
  value = github_repository.terraform-first-repo.html_url
}