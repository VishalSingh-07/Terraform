output printUsersAge{
    value = "Hi, my name is ram and my age is ${lookup(var.usersAge,"ram")}"
}