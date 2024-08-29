terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }

  # backend "azurerm" {
  #   # Intentionally blank - https://julie.io/writing/terraform-on-azure-pipelines-best-practices/
  # }
}

provider "azurerm" {
  # Configuration options
  # subscription_id = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"        # Set this to the subscription within which your resource group is or will be created.
  features {}
}

provider "tls" {
  # Configuration options
}