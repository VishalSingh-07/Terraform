output printFirstUser{
    value = "first user is ${(var.users[1])}"
}

output printList{
    value = "${join(" - ",var.users)}"
}

output upperCase{
    value = "${upper(var.users[0])}"
}

output lowerCase{
    value = "${lower(var.users[2])}"
}

output titleCase{
    value = "${title(var.users[3])}"
}