variable "project_name" {
  type        = string
  description = "Prefix for all Azure resource names."
  default     = "iac-demonstration"
}

variable "location" {
  type        = string
  description = "Azure region for resources."
  default     = "swedencentral"
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

variable "container_port" {
  type        = number
  description = "TCP port exposed by the container."
  default     = 80
}
