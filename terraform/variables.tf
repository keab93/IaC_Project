variable "project_name" {
  type        = string
  description = "Prefix for all Azure resource names."
  default     = "iac-project-demonstration"
}

variable "resource_group_name" {
  type        = string
  description = "Name of existing Azure resource group (data source)."
  default     = "iac-project-demonstration-rg"
}

variable "dns_name_label" {
  type        = string
  description = "DNS label for the container group (must be globally unique)."
  default     = "iac-demonstation-aci"
}

variable "container_image" {
  type        = string
  description = "Container image to run."
  default     = "mcr.microsoft.com/oss/nginx/nginx:1.9.15-alpine"
}

variable "usermgmt_image" {
  type        = string
  description = "User management container image."
  default     = "kenanatridesreg1.azurecr.io/usermgmt:latest"
}

variable "usermgmt_port" {
  type        = number
  description = "TCP port exposed by the user management container."
  default     = 82
}

variable "container_cpu" {
  type        = number
  description = "CPU cores for the container."
  default     = 0.5
}

variable "container_memory" {
  type        = number
  description = "Memory (GB) for the container."
  default     = 1.0
}

variable "location" {
  default = "swedencentral"

}

variable "container_port" {
  type        = number
  description = "TCP port exposed by the container."
  default     = 81
}

variable "usermgmt_cpu" {
  type        = number
  description = "CPU cores for user management container."
  default     = 0.5
}

variable "usermgmt_memory" {
  type        = number
  description = "Memory (GB) for user management container."
  default     = 0.5
}
