terraform {
  required_version = "~> 1.4.4"

  backend "azurerm" {
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.51.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.37.1"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

provider "azuread" {
}
