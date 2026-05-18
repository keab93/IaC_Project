output "public_ip" {
  description = "Public IP address of the container group."
  value       = azurerm_container_group.aci.ip_address
}

output "http_url" {
  description = "HTTP URL for the container app."
  value       = azurerm_container_group.aci.fqdn != "" ? "http://${azurerm_container_group.aci.fqdn}" : "http://${azurerm_container_group.aci.ip_address}"
}

output "fqdn" {
  description = "DNS name for the container group."
  value       = azurerm_container_group.aci.fqdn
}
