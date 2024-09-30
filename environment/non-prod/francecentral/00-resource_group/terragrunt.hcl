locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/../common.yaml"))
}

terraform {
  source = "Azure/resource-group/azurerm"
  version = ">= 2.0.0"
}

inputs = {
  resource_group_name = "terraform-${local.common_vars.environment}-rg"
  location            = local.common_vars.location
}