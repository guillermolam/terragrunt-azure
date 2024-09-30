module "avm-ptn-aks-production" {
  source  = "Azure/avm-ptn-aks-production/azurerm"
  version = "0.1.0"

  location                        = var.region
  resource_group_name             = var.resource_group_name
  rbac_aad_admin_group_object_ids = var.rbac_aad_admin_group_object_ids

  enable_kube_dashboard           = var.enable_kube_dashboard
  prefix                          = var.prefix
  rbac_aad_client_app_id          = var.rbac_aad_client_app_id
  rbac_aad_server_app_id          = var.rbac_aad_server_app_id
  rbac_aad_server_app_secret      = var.rbac_aad_server_app_secret
  vnet_subnet_id                  = var.vnet_subnet_id
}