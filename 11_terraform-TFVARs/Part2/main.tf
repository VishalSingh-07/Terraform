variable "age" {
    type = number
}
variable "username" {
  type = string
}

output "printUser" {
  value = "Hello, ${var.username}, your age is ${var.age}"
}