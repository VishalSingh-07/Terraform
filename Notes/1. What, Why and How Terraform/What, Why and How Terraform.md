
### What, Why and How Terraform

Before getting into the Tutorial, we should understand Why Terraform is needed in the first place. Creating and managing application instances in Data centers is a really crucial job and it cannot even afford a small mistake or misconfiguration. Wait! even application developers do mistakes with their application codes but how they are managing it to avoid big downtime or issue? Yes, They have everything coded and everyone has their own versions of code which can be reviewed and approved!. Likewise, creating code for Infrastructure will help misconfiguration, and most importantly, it will automate the way long infrastructure processes. Now, Terraform provide such a platform that will store the configuration of infrastructure with configuration, provision, and manage feature as code. We call that Infrastructure as Code (IaC).

Terraform is an infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure safely and efficiently. This includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc. Terraform can manage both existing service providers and custom in-house solutions.

Terraform's configuration language is declarative, meaning that it describes the desired end-state for your infrastructure, in contrast to procedural programming languages that require step-by-step instructions to perform tasks. Terraform providers automatically calculate dependencies between resources to create or destroy them in the correct order.

Terraform is HashiCorp's infrastructure as a code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle. Using Terraform has several advantages over manually managing your infrastructure.

Terraform is an orchestration engine and language that enables you to safely and predictably create, change, and improve production infrastructure. It is an open-source tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.

#### What is Terraform used for?

* **External resource management** -- Terraform supports public and private cloud infrastructure, as well as network appliances and software as a service (SaaS) deployments.
* **Multi-cloud deployment** -- the software tool's native ability to support multiple cloud services helps increase fault tolerance.
* **Multi-tier applications** -- Terraform allows each resource collection to easily be scaled up or down as needed.
* **Self-service clusters** -- the registries make it easy for users to find prepackaged configurations that can be used as is or modified to meet a particular need.
* **Software-defined networking (SDN)** -- Terraform's readability makes it easy for network engineers to codify the configuration for an SDN.
* **Resource scheduler** -- Terraform modules can stop and start resources on AWS and allow Kubernetes to schedule Docker containers.
* **Disposable environments** -- modules can be used to create an ad hoc, throwaway test environment for code before it's put into production.


#### How does Terraform work?

Terraform allows users to define their entire infrastructure simply by using configuration files and version control. When a command is given to deploy and run a server, database or load balancer, Terraform parses the code and translates it into an application programming interface (API) call to the resource provider. Because Terraform is open source, developers are always able to extend the tool's usefulness by writing new plugins or compiling different versions of existing plugins.

Terraform has two important components: **Terraform Core** and **Terraform Plugins.**

**Terraform Core** oversees the reading and interpolation of resource plan executions, resource graphs, state management features and configuration files. Core is composed of compiled binaries written in the Go programming language. Each compiled binary acts as a command-line interface (CLI) for communicating with plugins through remote procedure calls (RPC).

**Terraform Plugins** are responsible for defining resources for specific services. This includes authenticating infrastructure providers and initializing the libraries used to make API calls. Terraform Plugins are written in Go as executable binaries that can either be used as a specific service or as a provisioner. (Provisioner plugins are used to execute commands for a designated resource.)

#### Features of Terraform
* **Reuse:** Infrastructure as code (IaC) tools allow you to manage infrastructure with configuration files rather than through a graphical user interface. IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share.
* **Execution Plans:** Terraform generates an execution plan describing what it will do and asks for your approval before making any infrastructure changes. This allows you to review changes before Terraform creates, updates, or destroys infrastructure.
* **Resource Graph:** Terraform builds a resource graph and creates or modifies non-dependent resources in parallel. This allows Terraform to build resources as efficiently as possible and gives you greater insight into your infrastructure.
* **Change Automation:** Terraform can apply complex changesets to your infrastructure with minimal human interaction. When you update configuration files, Terraform determines what changed and creates incremental execution plans that respect dependencies.
	* Terraform can manage infrastructure on multiple cloud platforms.
	* The human-readable configuration language helps you write infrastructure code quickly.
	* Terraform's state allows you to track resource changes throughout your deployments.
	* You can commit your configurations to version control to safely collaborate on infrastructure.
* **Manage any infrastructure:** Terraform plugins called providers let Terraform interact with cloud platforms and other services via their application programming interfaces (APIs). HashiCorp and the Terraform community have written over 1,000 providers to manage resources on Amazon Web Services (AWS), Azure, Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Splunk, and DataDog, just to name a few. Find providers for many of the platforms and services you already use in the Terraform Registry.
	* If you don't find the provider you're looking for you can write your own provider plugin.
	* make incremental changes to resources.
	* Standardize your deployment workflow Providers define individual units of infrastructure, for example compute instances or private networks, as resources. You can compose resources from different providers into reusable Terraform configurations called modules, and manage them with a consistent language and workflow.
* **Track your infrastructure:** Terraform keeps track of your real infrastructure in a state file, which acts as a source of truth for your environment. Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.
* **Collaborate:** Terraform allows you to collaborate on your infrastructure with its remote state backends. When you use Terraform Cloud (free for up to five users), you can securely share your state with your teammates, provide a stable environment for Terraform to run in, and prevent race conditions when multiple people make configuration changes at once.
* You can also connect **Terraform Cloud** to version control systems (VCSs) like GitHub, GitLab, and others, allowing it to automatically propose infrastructure changes when you commit configuration changes to VCS. This lets you manage changes to your infrastructure through version control, as you would with application code.

#### Benefits of Using Terraform
* Manual Needs many Human Resources which can be Managed by a single Terraform Platform.
* Since we need fewer human resources, the Cost of Infrastructure management can be reduced drastically.
* Misconfiguration and Manual errors can be taken away by Terraform
* Scaling or High Availability of the Application stack within Infrastructure can be easily achieved with Terraform.
* The Infrastructure setup is available as Configuration Files, It can be Documented and Reviewed every version of the changes.
* No Blame Games in Infrastructure Configurations. It can be traced back and Identified easily.
* HashiCorp offers a commercial version of Terraform called Terraform Enterprise. According to the HashiCorp website, the commercial version includes enterprise features on top of open source Terraform and includes a framework called Sentinel that can implement policy as code.


