variable "project_name" {
  type        = string
  description = "Prefix for all Azure resource names."
  default     = "iac-demo"
}

variable "location" {
  type        = string
  description = "Azure region for resources."
  default     = "swedencentral"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
  default     = "demoadmin"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key to authorize."
  default     = "~/.ssh/id_ed25519.pub"
}
