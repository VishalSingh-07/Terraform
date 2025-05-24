
### Multiple Terraform File in the Same Directory

Let's create the below files in the same directory add the below content in the **first.tf** file
```json
output "firstoutputblock" {
        value = " this is first hello world block"
}
```

add the below content in **second.tf** file
```json
output "secondoutputblock" {
        value = "this is second hello world block"
}
```

add the below content in **third.tf** file
```json
output "thirdoutputblock" {
        value = "this is third hello world block"
}
```

now we have four files in our current working directory lets list them using ls command.
```sh
┌──(gaurav㉿learning-ocean)-[~/youtube-course/hello-world-file-destructure]
└─$ ls
first.tf  second.tf  third.tf

┌──(gaurav㉿learning-ocean)-[~/youtube-course/hello-world-file-destructure]
└─$
now let's run terraform plan command in the same directory.
┌──(gaurav㉿learning-ocean)-[~/youtube-course/hello-world-file-destructure]
└─$ terraform plan

Changes to Outputs:
  + firstoutputblock  = " this is first hello world block"
  + secondoutputblock = "this is second hello world block"
  + thirdoutputblock  = "this is third hello world block"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


**So, when we run terraform plan or apply command then all the `tf` files that are present in the present working directory are loaded.**

Now I have a questions for you guys,

How these files will get loaded while running terraform plan?

So let's create one more file in **abc.tf** in the same directory with the below command

```json
output "abc" {
        value = "this is abc hello world block"
}
```

Now we have four files in our current working directory lets list them using ls command.
```sh
┌──(gaurav㉿learning-ocean)-[~/youtube-course/hello-world-file-destructure]
└─$ ls
abc.tf  first.tf  second.tf  third.tf

┌──(gaurav㉿learning-ocean)-[~/youtube-course/hello-world-file-destructure]
└─$
let's run terraform plan command and check the output.
┌──(gaurav㉿learning-ocean)-[~/youtube-course/hello-world-file-destructure]
└─$ terraform plan

Changes to Outputs:
  + abc               = "this is abc hello world block"
  + firstoutputblock  = " this is first hello world block"
  + secondoutputblock = "this is second hello world block"
  + thirdoutputblock  = "this is third hello world block"
```


You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.


> [!NOTE] Note
> **All the files in the folder is loaded in the alphabetic order.**



