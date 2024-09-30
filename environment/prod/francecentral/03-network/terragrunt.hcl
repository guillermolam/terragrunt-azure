skip = true

locals {
  common_vars = yamldecode(file("${get_terragrunt_dir()}/../common.yaml"))
  env_vars    = yamldecode(file("${get_terragrunt_dir()}/../${local.common_vars.environment}.yaml"))
}

terraform {
  source = "Azure/vnet/azurerm"
  version = "4.1.0"
}

# Define dependencies to ensure network is applied after resource group, storage account, and storage container
dependencies {
  paths = [
    "../resource_group",
    "../storage_account",
    "../storage_container"
  ]
}

inputs = {
  resource_group_name = "aks-${local.common_vars.environment}-rg"
  location            = local.common_vars.location
  vnet_name           = local.common_vars.vnet_name
  address_space       = local.common_vars.vnet_address_space

  # Define subnets within the VNet
  subnets = [
    {
      name            = local.common_vars.aks_subnet_name
      address_prefixes = local.common_vars.aks_subnet_address_prefixes
    }
  ]

  # Optional security settings for the subnets
  nsg_rules = {
    "${local.common_vars.aks_subnet_name}-nsg" = {
      name        = "${local.common_vars.aks_subnet_name}-nsg"
      description = "NSG for AKS subnet"
      security_rules = [
        {
          name                       = "allow_aks_inbound"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
          description                = "Allow all inbound traffic to AKS"
        },
        {
          name                       = "deny_all_inbound"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
          description                = "Deny all other inbound traffic"
        }
      ]
    }
  }

  # Enable DDoS protection for the VNet
  enable_ddos_protection = true
  ddos_protection_plan = {
    id = null  # Replace with the ID of the DDoS protection plan if applicable
  }
}