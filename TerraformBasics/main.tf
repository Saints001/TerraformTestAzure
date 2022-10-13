# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.52.0"
      }
    }

  backend "azurerm" {
    resource_group_name   = "BusolaRG"
    storage_account_name  = "busolastorage"
    container_name        = "busolastate"
    key                   = "vX2aWnTRG1tjNRKalXyOFB6x49n614UegwcCUTnwIW7W7vk4OR5/iarncFntBqov9I7Fsx3MqT23+AStvQhjiw=="
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "myrg" {
  name     = "jonnychipz-rg"
  location = var.primary_location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "myvnet" {
  name                = "jonnychipz-vnet"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet within the vnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "jonnychipz-subnet"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}