
### Terraform Functions

The Terraform language includes a number of built-in functions that you can call from within expressions to transform and combine values. The general syntax for function calls is a function name followed by comma-separated arguments in parentheses

```
max(5, 12, 9)
```

The Terraform language **does not support user-defined functions**, and so only the functions built into the language are available for use.

##### Numeric Functions
* **abs:** abs returns the absolute value of the given number. In other words, if the number is zero or positive then it is returned as-is, but if it is negative then it is multiplied by -1 to make it positive before returning it.
	```sh
    > abs(24)
	23
    > abs(0)
	0
    > abs(-24.4)
    24.4
	```

* **ceil:** ceil returns the closest whole number that is greater than or equal to the given value, which may be a fraction.
	```sh
    > ceil(5)
	5
    > ceil(5.1)
	6
	```

- **floor:** floor returns the closest whole number that is less than or equal to the given value, which may be a fraction.
	```sh
    > floor(5)
	5
    > floor(4.9)
	4
	```

- **log:** log returns the logarithm of a given number in a given base.
	```sh
    > log(50, 10)
	1.6989700043360185
    > log(16, 2)
	4
	```

- **max:** max takes one or more numbers and returns the greatest number from the set.
	```sh
    > max(12, 54, 3)
	54
	```

- **min:** min takes one or more numbers and returns the smallest number from the set.
	```sh
    > min(12, 54, 3)
	3
	```

- **pow:** pow calculates an exponent, by raising its first argument to the power of the second argument.
	```sh
    > pow(3, 2)
	9
    > pow(4, 0)
	1
	```

##### String Functions

- **join:** join produces a string by concatenating together all elements of a given list of strings with the given delimiter.
	```sh
    > join(", ", ["foo", "bar", "baz"])
	foo, bar, baz
    > join(", ", ["foo"])
	foo
	```

- **upper:** upper converts all cased letters in the given string to uppercase.
	```sh
    > upper("hello")
	HELLO
	```

- **lower:** lower converts all cased letters in the given string to lowercase.
	```sh
    > lower("HELLO")
	hello
	```

- **title:** title converts the first letter of each word in the given string to uppercase.
	```sh
    > title("hello world")
	Hello World
	```



Lets take an example of String functions

create a file **variable.tf** with below code:
```json
variable users {
  type = list
  default = ["ram","Shyam","LuV","kush"]
}
```

create a file **main.tf** (you can change the file name as per your convenient.
```json
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
```


Let's run terraform apply and see the output:
```sh
vishalsingh@197NOMBT3987 9_terraform-functions % terraform plan

Changes to Outputs:
  + lowerCase      = "luv"
  + printFirstUser = "first user is Shyam"
  + printList      = "ram - Shyam - LuV - kush"
  + titleCase      = "Kush"
  + upperCase      = "RAM"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

```

Below are the types of other functions with function names:
* **Numeric Functions :** abs, ceil, floor, log, max, min, parseint, pow, signum
* **String Functions:** chomp, format, formalist, join, lower, regex, regexall, replace, split, strrev, title, trim, trimprefix, trimsuffix, trimspace, upper
* **Collection Functions:** alltrue, anytrue, chunklist, coalesce, coalescelist, compact, concat, contains, distinct, element, flatten, index, keys, length, list, lookup, map, matchkeys,merge, one, range, reverse, setintersection, setproduct, setsubsctract, setunion, slice, sort, sum, transpose, values, zipmap
* **Encoding Functions:** base643ncode, base64decode, base64gzip, csvdecode, jsonencode, jsondecode, urlencode, yamlencode, yamldecode
* **Filesystem functions:** absath, dirname, pathexpand, basename, file, fileexists, fileset, filebase64, templatefile
* **Date & Time Functions:** formade, timeadd, timestamp
* Hash and Crypto Functions : base64sha256, base64sha512, bcrypt, filebase64sha512, filemd5, filesha1, filesha256, filesha512, md5, rsadecrypt, sha, sha256, sha512, uuid, uuidv5
* **IP Network Functions:** cidrhost, cidrnetmask, cidrsubnets
* **Type Conversion functions:** can, defaults, nonsensative, sensitive, tobool, tolist, tomap, tonumber, toset, tostring, try


**Reference Link for Terraform Function -**
* **[Functions - Configuration Language | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/functions)**


