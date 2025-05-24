variable users {
  type = list
}

output print{
    value = "first user is ${(var.users[1])}"
}