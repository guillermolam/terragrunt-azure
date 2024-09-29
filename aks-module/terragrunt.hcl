terraform {
  # Include the common Terraform CLI arguments from the root terragrunt.hcl file
  include {
    path = find_in_parent_folders()
  }

  # Other module-specific configurations
}

locals {
  # Azure region where the VM will be deployed
  region = "UK South"
}