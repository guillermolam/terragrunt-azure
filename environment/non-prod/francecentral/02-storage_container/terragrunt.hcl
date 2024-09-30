locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/../common.yaml"))
  env_vars    = yamldecode(file("${get_terragrunt_dir()}/../${local.common_vars.environment}.yaml"))
}

dependency "storage_account" {
  config_path = "../storage_account"
}

terraform {
  source = "Azure/storage-container/azurerm"
  version = ">= 2.0.0"
}

inputs = {
  container_name        = local.env_vars.container_name
  storage_account_name  = dependency.storage_account.outputs.name
  container_access_type = "private"
}