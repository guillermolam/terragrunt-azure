# Load common and environment-specific configurations
locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/common.yaml"))
  env_vars    = yamldecode(file("${get_terragrunt_dir()}/${local.common_vars.environment}.yaml"))
}

# Define where child configurations are located which are all local to the root module
terraform {
  source = "../../../..//modules/${basename(get_terragrunt_dir())}"
}

# Add retry lock for long-running operations
extra_arguments "retry_lock" {
  commands  = get_terraform_commands_that_need_locking()
  arguments = ["-lock-timeout=20m"]
  env_vars  = ["TF_CLI_ARGS_init=-reconfigure"]
}

# Before applying or planning, run "pnpm run lint"
before_hook "before_hook_1" {
  commands = ["apply", "plan"]
  execute  = ["pnpm", "run lint"]
}

# Generate provider configurations for Azure and GitHub
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
}

provider "github" {
  token = getenv("GITHUB_TOKEN")
}
EOF
}