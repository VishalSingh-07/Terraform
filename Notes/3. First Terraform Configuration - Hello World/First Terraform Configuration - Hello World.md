
#### First Terraform Configuration - Hello World

**Terraform Language:**
The Terraform language is Terraform's primary user interface. In every edition of Terraform, a configuration written in the Terraform language is always at the heart of the workflow. The main purpose of the Terraform language is declaring resources, which represent infrastructure objects.

**Terraform configuration:**
A Terraform configuration is a complete document in the Terraform language that tells Terraform how to manage a given collection of infrastructure. A configuration can consist of multiple files and directories.

```json
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
    # Block body
    <IDENTIFIER> = <EXPRESSION> # Argument
}
```


**File Extension:**
Code in the Terraform language is stored in plain text files with the `.tf` file extension. There is also a JSON-based variant of the language that is named with the `.tf.json` file extension.

**Text Encoding:**
Configuration files must always use UTF-8 encoding, and by convention usually use Unix-style line endings (LF) rather than Windows-style line endings (CRLF), though both are accepted

let's create first terraform configurations create a file **first.tf** in the present working directory with the below content

```json
// this is comment
# this is comment

output hello{
    value = "Hello World"
}
```

now let's run terraform plan command

**Output**
```sh
vishalsingh@197NOMBT3987 Hello World % terraform plan

Changes to Outputs:
  + hello = "Hello World"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```


