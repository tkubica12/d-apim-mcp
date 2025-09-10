## Azure API Management Standard V2 (Terraform)

This configuration deploys:

* Resource Group: `d-apim-mcp`
* API Management Standard V2 (public, no virtual network) with capacity 1

### Files
* `main.tf` – resource group
* `apim.tf` – APIM service via AzAPI provider (StandardV2)
* `providers.tf` – provider definitions (azurerm, azapi, random)
* `variables.tf` – location & prefix inputs
* `locals.tf` – randomized base name used for APIM instance name

### Usage
Initialize & deploy (PowerShell):
```pwsh
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

### Outputs
* `apim_name` – APIM service name
* `apim_id` – Resource ID

### Notes
* StandardV2 currently surfaced through the AzAPI resource definition using API version `2024-10-01-preview`.
* Adjust `publisherName` / `publisherEmail` in `apim.tf` to match your organization.
* Increase capacity by changing `capacity` under `sku`.
