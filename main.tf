terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}
provider "azurerm" {
features {}
   subscription_id = "7ea1702d-d0c5-423b-ba9a-b69218aaf564"
}

locals {
  tags = {
    Environment = var.environment // Ensure variable name consistency
  }
}

resource "azurerm_storage_account" "securestorage" {
  resource_group_name           = var.resource_group_name
  location                      = var.location
  name                          = var.storage_account_name
  account_tier                  = "Standard"
  account_replication_type      = var.environment == "Production" ? "GRS" : "LRS"
  public_network_access_enabled = false

  tags = local.tags
}
