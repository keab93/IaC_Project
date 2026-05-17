output "public_ip" {
  description = "Public IP address of the VM."
  value       = azurerm_public_ip.pip.ip_address
}

output "ssh_command" {
  description = "SSH command for the VM."
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.pip.ip_address}"
}

output "http_url" {
  description = "HTTP URL for Apache."
  value       = "http://${azurerm_public_ip.pip.ip_address}"
}
