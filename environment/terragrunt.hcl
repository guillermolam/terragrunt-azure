terraform {
    required_version = ">= 0.14.0"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">= 2.0"
        }
    }
}

locals {
  # Get current Environment
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.env_vars.locals.environment

  # Get Current Region
  region_vars = read_terragrunt_config(find_in_parent_folders("site.hcl"))
  region = local.region_vars.locals.region

  # Create prefix for resources and backend
  prefix = "${local.environment}-${local.region}"
  region_name="${local.prefix}-region"

  # Extract the variables we need for easy access
  subscription_id                        = local.env_vars.locals.subscription_id
  client_id                              = local.env_vars.locals.client_id
  client_secret                          = get_env("ARM_CLIENT_SECRET")
  tenant_id                              = local.env_vars.locals.tenant_id
  deployment_storage_resource_group_name = local.site_vars.locals.deployment_storage_resource_group_name
  deployment_storage_account_name        = local.site_vars.locals.deployment_storage_account_name
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  =  "resource_group_for_storage_account"
    storage_account_name = "terraformdevtfstatestacc"
    container_name       = "terraformtfstatecontainer"
    key            = "${path_relative_to_include()}/${get_env("ENVIRONMENT", "")}.terraform.tfstate"
  }
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an Blob Storage container
remote_state {
  backend = "azurerm"

  config = {
    subscription_id      = local.subscription_id
    resource_group_name  = local.deployment_storage_resource_group_name
    storage_account_name = local.deployment_storage_account_name
    container_name       = "terraform-state"
    key                  = "${path_relative_to_include("site")}/terraform.tfstate"
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.env_vars.locals,
  local.site_vars.locals,
  {
    client_secret = local.client_secret
  }
)