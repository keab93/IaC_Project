terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}




data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_container_registry" "acr" {
  name                = "kenanatridesreg1"
  resource_group_name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "container_identity" {
  name                = "container-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.container_identity.principal_id
}


# Long-running web service: gets a public IP/DNS name and restarts if it crashes.
resource "azurerm_container_group" "web" {
  name                = "${var.project_name}-web-cg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label
  os_type             = "Linux"
  restart_policy      = "Always"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_identity.id]
  }

  image_registry_credential {
    server                    = data.azurerm_container_registry.acr.login_server
    user_assigned_identity_id = azurerm_user_assigned_identity.container_identity.id
  }

  depends_on = [azurerm_role_assignment.acr_pull]

  container {
    name   = "web"
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = var.container_port
      protocol = "TCP"
    }
  }

  tags = {
    project = var.project_name
  }
}

# One-shot provisioning job: runs the user management script once and exits.
# This container group is a batch job.
# NEXT STEP: move this off ACI to a runtime with a persistent filesystem
# (e.g. a VM via cloud-init, or an Azure Automation runbook) so created
# users survive past a single container lifetime.
resource "azurerm_container_group" "usermgmt" {
  name                = "${var.project_name}-usermgmt-cg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  ip_address_type     = "None"
  os_type             = "Linux"
  restart_policy      = "Never"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.container_identity.id]
  }

  image_registry_credential {
    server                    = data.azurerm_container_registry.acr.login_server
    user_assigned_identity_id = azurerm_user_assigned_identity.container_identity.id
  }

  depends_on = [azurerm_role_assignment.acr_pull]

  container {
    name   = "usermgmt"
    image  = "${data.azurerm_container_registry.acr.login_server}/usermgmt:latest"
    cpu    = var.usermgmt_cpu
    memory = var.usermgmt_memory
  }

  tags = {
    project = var.project_name
  }
}
