output printUsersAge{
    value = "Hi, my name is ${var.username} and my age is ${lookup(var.usersAge,var.username)}"
}