// Container Apps Managed Environment (no VNet, public access)
// Using latest preview API supporting workload profiles.

resource "azapi_resource" "ca_env" {
  type      = "Microsoft.App/managedEnvironments@2025-02-02-preview"
  name      = "cae-${local.base_name}"
  parent_id = azurerm_resource_group.main.id
  location  = azurerm_resource_group.main.location

  body = {
    properties = {
      publicNetworkAccess = "Enabled"
      workloadProfiles = [
        {
          name                = "consumption"
          workloadProfileType = "Consumption"
        }
      ]
      appInsightsConfiguration = {
        connectionString = azurerm_application_insights.main.connection_string
      }
      appLogsConfiguration = {
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          customerId = azurerm_log_analytics_workspace.main.workspace_id
          sharedKey  = azurerm_log_analytics_workspace.main.primary_shared_key
        }
      }
    }
  }
}

output "containerapp_environment_id" {
  value = azapi_resource.ca_env.id
}
