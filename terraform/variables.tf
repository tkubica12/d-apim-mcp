variable "prefix" {
  type        = string
  default     = "mcp"
  description = <<EOF
Prefix for resources.
Preferably 2-4 characters long without special characters, lowercase.
EOF
}

variable "location" {
  type        = string
  default     = "swedencentral"
  description = <<EOF
Azure region for resources.

Examples: swedencentral, westeurope, northeurope, germanywestcentral.
EOF
}

variable "api_image" {
  type        = string
  default     = "ghcr.io/tkubica12/d-apim-mcp/say-hello-api:latest"
  description = "Container image for the public API service (update after pushing your own image)."
}

variable "mcp_image" {
  type        = string
  default     = "ghcr.io/tkubica12/d-apim-mcp/say-hello-mcp:latest"
  description = "Container image for the MCP service (update after pushing your own image)."
}