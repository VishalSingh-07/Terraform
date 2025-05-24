
### Terraform Core and Plugins

Terraform is logically split into two main parts: **Terraform Core** and **Terraform Plugins**. Terraform Core uses remote procedure calls (RPC) to communicate with Terraform Plugins, and offers multiple ways to discover and load plugins to use. Terraform Plugins expose an implementation for a specific service, such as AWS, or provisioner, such as bash.

##### Terraform Core
Terraform Core is a statically-compiled binary written in the Go programming language. The compiled binary is the command line tool (CLI) terraform, the entry point for anyone using Terraform.

###### Responsibilities of terraform Core:
* Infrastructure as code: reading and interpolating configuration files and modules
* Resource state management
* Plan execution
* Construction of the Resource Graph
* Communication with plugins over RPC

##### Terraform Plugins
* Terraform Plugins are written in Go and are executable binaries invoked by Terraform Core over RPC. Each plugin exposes an implementation for a specific service, such as AWS, or provisioner, such as bash.
* All Providers and Provisioners used in Terraform configurations are plugins.
* They are executed as a separate process and communicate with the main Terraform binary over an RPC interface.
* Terraform has several Provisioners built-in, while Providers are discovered dynamically as needed.
* Terraform Core provides a high-level framework that abstracts away the details of plugin discovery and RPC communication so developers do not need to manage either.
* Terraform Plugins are responsible for the domain-specific implementation of their type.

###### Responsibilities of Provider Plugins are
* Initialization of any included libraries used to make API calls
* Authentication with the Infrastructure Provider
* Define Resources that map to specific Services

###### Responsibilities of Provisioner Plugins are
* Executing commands or scripts on the designated Resource after creation, or on destruction.


##### Some Diagram of Terraform:

![image.png](../Images/terraform-core-and-plugins-image-1.png)

![image.png](../Images/terraform-core-and-plugins-image-2.png)

![image.png](../Images/terraform-core-and-plugins-image-3.png)



Terraform Providers:
**[Browse Providers | Terraform Registry](https://registry.terraform.io/browse/providers)**


