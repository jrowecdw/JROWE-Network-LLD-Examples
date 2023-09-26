terraform {
  required_version = ">= 0.15"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Allow minor updates, try to stay within last six months
      configuration_aliases = [azurerm.sub01, azurerm.sub02,azurerm.sub03,azurerm.sub04,azurerm.sub05]
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}