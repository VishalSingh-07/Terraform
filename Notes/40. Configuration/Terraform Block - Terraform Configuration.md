
### Terraform Block - Terraform Configuration

The special terraform configuration block type is used to configure some **behaviors** of Terraform itself, such as requiring a minimum Terraform version to apply your configuration.

Each terraform block can contain a number of settings related to Terraform's behavior. Within a terraform block, only constant values can be used; arguments may not refer to named objects such as resources, input variables, etc, and may not use any of the Terraform language built-in functions.


**Specifying a Required Terraform Version**

The `required_version` setting can be used to constrain which versions of the Terraform CLI can be used with your configuration. If the running version of Terraform doesn't match the constraints specified, Terraform will produce an error and exit without taking any further actions.

The value for `required_version` is a string containing a comma-separated list of constraints. Each constraint is an operator followed by a version number, such as > 0.12.0. The following constraint operators are allowed:

- **= (or no operator):** exact version equality
- **!=:** version not equal
- **>, >=, <, <=:** version comparison, where **greater than** is a larger version number
- **~>:** pessimistic constraint operator, constraining both the oldest and newest version allowed. For example, ~> 0.9 is equivalent to >= 0.9, < 1.0, and ~> 0.8.4, is equivalent to >= 0.8.4, < 0.9


| **Required Version** | **Meaning**                                       | **Considerations**                                            |
| -------------------- | ------------------------------------------------- | ------------------------------------------------------------- |
| 1.7.5                | Only Terraform v1.7.5 exactly                     | To upgrade Terraform, first edit the required_version setting |
| >= 1.7.5             | Any Terraform v1.7.5 or greater                   | Includes Terraform v2.0.0 and above                           |
| ~> 1.7.5             | Any Terraform v1.7.x, but not v1.8 or later       | Minor version updates are intended to be non-disruptive       |
| >= 1.7.5, < 1.9.5    | Terraform v1.7.5 or greater, but less than v1.9.5 | Avoids specific version updates                               |

  
**Specifying Required Provider Versions**

- The required_providers setting is a map specifying a version constraint for each provider required by your configuration.
- This is one of several ways to define provider version constraints and is particularly suited to re-usable modules that expect a provider configuration to be provided by their caller but still need to impose a minimum version for that provider.

  

Let's use terraform block in our code. create a new file named **terraform.tf** with the below content

```json
terraform {
    required_version = "1.9.8"
  required_providers {
    aws = {
      _source_  = "hashicorp/aws"
      _version_ = "~> 5.0"
    }
  }
}
```