// Container App: MCP service
resource "azapi_resource" "mcp_app" {
  type      = "Microsoft.App/containerApps@2025-02-02-preview"
  name      = "mcp-${local.base_name}"
  parent_id = azurerm_resource_group.main.id
  location  = azurerm_resource_group.main.location

  body = {
    properties = {
      environmentId       = azapi_resource.ca_env.id
      workloadProfileName = "consumption"
      configuration = {
        ingress = {
          external      = true
          targetPort    = 8765
          transport     = "auto"
          allowInsecure = false
        }
        activeRevisionsMode = "Single"
      }
      template = {
        containers = [
          {
            name  = "mcp"
            image = var.mcp_image
            resources = {
              cpu    = 0.25
              memory = "0.5Gi"
            }
          }
        ]
        scale = {
          minReplicas = 1
          maxReplicas = 1
        }
      }
    }
  }
}

output "mcp_containerapp_fqdn" {
  value = azapi_resource.mcp_app.output.properties.configuration.ingress.fqdn
}
