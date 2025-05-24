
### Multiple Block in Single Terraform File

In the previous blogs, we used single-output block in a file. In this blog, we will demonstrate that we can use multiple blocks in the same file.

let create the **first.tf** file in the present working directory with the below content. Here we can see that we are using multiple blogs in the same file. make source that label must be different.

```json
output "firstoutputblock"{
    value = "This is the first hello world block"
}
output "secondoutputblock"{
    value="This is the second hello world block"
}
output "thirdoutputblock"{
    value="This is the third hello world block"
}
```

now run terraform plan and see the output.


**Output:**

```sh
vishalsingh@197NOMBT3987 Terraform % cd hello-world-multi-block
vishalsingh@197NOMBT3987 hello-world-multi-block % terraform plan

Changes to Outputs:
  + firstoutputblock  = "This is the first hello world block"
  + secondoutputblock = "This is the second hello world block"
  + thirdoutputblock  = "This is the third hello world block"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


###### Multiple Terraform file in Same Directory

**first.tf** 
```json
output "firstoutputblock"{
    value = "This is the first hello world block"
} 
```

**second.tf** 
```json
output "secondoutputblock"{
    value="This is the second hello world block"
}
```

**third.tf**
```json
output "thirdoutputblock"{
    value="This is the third hello world block"
}
```


**File will be load in alphabetical sequence.** 


**Output:**
```sh
vishalsingh@197NOMBT3987 Terraform % cd 4_hello-world-file-destructure 
vishalsingh@197NOMBT3987 4_hello-world-file-destructure % terraform plan

Changes to Outputs:
  + firstoutputblock  = "This is the first hello world block"
  + secondoutputblock = "This is the second hello world block"
  + thirdoutputblock  = "This is the third hello world block"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```



