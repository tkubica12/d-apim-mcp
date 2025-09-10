resource "azurerm_resource_group" "main" {
  name     = "d-apim-mcp"
  location = var.location
}

resource "random_string" "main" {
  length  = 4
  special = false
  upper   = false
  numeric = false
  lower   = true
}

data "azurerm_client_config" "current" {}
