## Azure API Management + Container Apps Environment (Terraform)

This configuration deploys:

* Resource Group: `d-apim-mcp`
* API Management Standard V2 (public, no virtual network) with capacity 1 (AzAPI)
* Log Analytics Workspace (for Container Apps & App Insights logs)
* Application Insights (connected to workspace)
* Container Apps Managed Environment (public, no VNet) with workload profiles:
	* `consumption` (serverless consumption)
	* `cust-small` (sample dedicated profile type `D4`)
* Container App `api` (public ingress on port 8000, HTTP autoscale rule)
* Container App `mcp` (public ingress on port 8000)

All Container App related resources are defined with AzAPI provider using API version `2025-02-02-preview`.

### Files
* `main.tf` – resource group
* `apim.tf` – APIM service via AzAPI provider (StandardV2)
* `providers.tf` – provider definitions (azurerm, azapi, random)
* `variables.tf` – location & prefix inputs
* `locals.tf` – randomized base name used for APIM instance name
* `monitoring.tf` – Log Analytics + Application Insights
* `containerapp.env.tf` – Managed Environment with workload profiles
* `containerapp.api.tf` – API container app
* `containerapp.mcp.tf` – MCP container app

### Usage
Initialize & deploy (PowerShell):
```pwsh
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

### Outputs
* `apim_name` – APIM service name
* `apim_id` – APIM Resource ID
* `log_analytics_workspace_id` – Workspace resource ID
* `app_insights_connection_string` – AI connection string (for reference only)
* `containerapp_environment_id` – Managed Environment resource ID
* `api_containerapp_fqdn` – FQDN for API app ingress
* `mcp_containerapp_fqdn` – FQDN for MCP app ingress

### Notes
* StandardV2 currently surfaced through the AzAPI resource definition using API version `2024-06-01-preview` (newer preview failed schema validation at time of authoring).
* Container Apps preview API `2025-02-02-preview` used for workload profiles.
* Update `api_image` and `mcp_image` variables to point to your built images (ACR, Docker Hub, etc.).
* Auto-scaling rule for API based on concurrent HTTP requests (threshold 50).
* Adjust `publisherName` / `publisherEmail` in `apim.tf` to match your organization.
* Increase capacity by changing `capacity` under `sku`.
