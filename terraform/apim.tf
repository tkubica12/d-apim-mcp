// Azure API Management Standard v2 (no VNet integration)
// Deployed using AzAPI because StandardV2 currently requires latest API version.

resource "azapi_resource" "apim" {
  # Using latest version supported by current azapi provider (2024-06-01-preview) instead of 2024-10-01-preview which failed schema validation
  type      = "Microsoft.ApiManagement/service@2024-06-01-preview"
  name      = "apim-${local.base_name}"
  parent_id = azurerm_resource_group.main.id
  location  = azurerm_resource_group.main.location

  body = {
    properties = {
      publisherName       = "Contoso"
      publisherEmail      = "admin@contoso.com"
      publicNetworkAccess = "Enabled"
      virtualNetworkType  = "None"
    }
    sku = {
      name     = "StandardV2"
      capacity = 1
    }
  }
}

output "apim_name" {
  value = azapi_resource.apim.name
}

output "apim_id" {
  value = azapi_resource.apim.id
}
