
### Installation of Terraform on MacBook

* Download the **ARM File** from Terraform website
* Unzip the file.
* Find the path: `echo $PATH`
* Move the terraform to `/usr/local/bin` by using the command `sudo mv terraform /usr/local/bin.`
* And later check whether terraform is install or not by using this command: `terraform -help`

```sh
vishalsingh@197NOMBT3987 Downloads % unzip terraform_1.9.8_darwin_arm64.zip 
Archive:  terraform_1.9.8_darwin_arm64.zip
  inflating: LICENSE.txt             
  inflating: terraform   
```

```sh
vishalsingh@197NOMBT3987 Downloads % echo $PATH
/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/sbin
```

```sh
vishalsingh@197NOMBT3987 Downloads % mv terraform /usr/local/bin
mv: rename terraform to /usr/local/bin/terraform: Permission denied
```

```sh
vishalsingh@197NOMBT3987 Downloads % sudo mv terraform /usr/local/bin
```

```sh
vishalsingh@197NOMBT3987 Downloads % terraform -help
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  metadata      Metadata related commands
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Execute integration tests for Terraform modules
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.


