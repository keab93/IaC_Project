output "public_ip" {
  description = "Public IP address of the web container group."
  value       = azurerm_container_group.web.ip_address
}

output "http_url" {
  description = "HTTP URL for the web container app."
  value       = azurerm_container_group.web.fqdn != "" ? "http://${azurerm_container_group.web.fqdn}" : "http://${azurerm_container_group.web.ip_address}"
}

output "fqdn" {
  description = "DNS name for the web container group."
  value       = azurerm_container_group.web.fqdn
}
