resource "azurerm_resource_group" "main_app_terraform_rg" {
  name     = "terraform_${var.environment}_rg"
  location = var.location
}

resource "azurerm_storage_account" "terraform_tfstate_storage_account" {
  name                     = "terraform${var.environment}stacc"
  resource_group_name      = azurerm_resource_group.main_app_terraform_rg.name
  location                 = azurerm_resource_group.main_app_terraform_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "terraform_tfstate_container" {
  name                  = "terraformtfstatecontainer"
  storage_account_name  = azurerm_storage_account.terraform_tfstate_storage_account.name
  container_access_type = "private"
}