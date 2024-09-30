skip = true

locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/../common.yaml"))
  env_vars    = yamldecode(file("${get_terragrunt_dir()}/../${local.common_vars.environment}.yaml"))
}

dependency "resource_group" {
  config_path = "../resource_group"
}

terraform {
  source = "Azure/storage-account/azurerm"
  version = ">= 2.0.0"
}

inputs = {
  storage_account_name     = local.env_vars.storage_account_name
  resource_group_name      = dependency.resource_group.outputs.name
  location                 = local.common_vars.location
  account_tier             = local.common_vars.account_tier
  account_replication_type = local.common_vars.account_replication_type
}