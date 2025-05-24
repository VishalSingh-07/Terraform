variable "username" {
  type = string
}

output "printUser" {
  value = "Hello, ${var.username}"
}