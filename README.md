# Introduction 
This project automates the steps as outlined in the Microsoft Learn article:
-  [Azure Virtual Machine Scale Set agents - Create the scale set](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-the-scale-set)

The latter steps in the article must still be completed within Azure DevOps to link the agent pool.

# Getting Started
The code has been written such that it can create or use an existing resource group within Azure - comment/uncomment the relevant section in ./main.tf

A sample .tfvars file has been included ./terraform.tfvars.sample. Remove the .sample suffix, edit the included values to suit your environment - naming conventions etc., and perform a terraform init / plan / apply cycle to build the Virtual machine scale set

# Microsoft Cloud Adoption Framework
I wrote this code to dovetail with my implementation of [Microsofts Cloud Adoption Framework in Terraform](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest). As such this code would target your **Platform/Management** management group using that resource group or an appropriate one created to house the Virtual Machine Scale set. 

An appropriate Virtual Network (VNET) and Subnet is created to which the virtual machine scale set (VMSS) is linked. The additional module `module "storage_subnet" {...}` demonstrates an extension to create an additional subnet to hold the private endpoint of your storage account holding the backend Terraform *.tfstate* data.
Similarly you might add another subnet for your Keyvault to house the required SAS key for access to the blob and potentially the generated SSH keys for the VMSS agents. Refer to my other project which details the generation of a SAS key for blob storage and stores it in Keyvault - [generate_and_store_sas](https://github.com/UCDWraith/generate_and_store_sas). The NSG rules could then be locked down appropriately

## Additional considerations
If you are using the [caf-enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) project you will need to link the newly created vnet to the relevant (VWAN) hub, additionally the VNET must be linked to the private DNS zones so the VMSS agent can properly resolve the private endpoint.

- I like to seperate my subnets and selectively link VNETs to only required private DNS zones.
- When linking VNETs to private DNS zones **auto registration** can only be enabled for one zone. Thus in a single shared subnet scenario (VMSS VM's, Storage private endpoint, Keyvault) you could not enable auto registration for the relevant zones.
- By default the [caf-enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) does not support selective linking of private DNS zones so it may be better implemented directly in the relevant project

## Firewall Access
Again with reference to this being deployed within [caf-enterprise-scale](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) the relevant subnet will require HTTPS outbound access to the internet. I have detailed a process to deploy Azure firewall rules with a Configuation-as-Code mindset in my project [azure_firewall_rules_CaC](https://github.com/UCDWraith/azure_firewall_rules_CaC)

# Contribute
It would be great to hear your thoughts/feedback on whether this has helped. If you think I can help your organisation please reach out.
