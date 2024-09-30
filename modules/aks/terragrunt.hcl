terraform {

  include {
    path = find_in_parent_folders()
  }
}

locals {
  # Azure region where the VM will be deployed
  region = "UK South"
}