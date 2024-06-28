# terraform {
#   backend "azurerm" {
#     resource_group_name   = "trn"
#     storage_account_name  = "trn"
#     container_name        = "tfcontainer"
#     key                   = "terraform.tfstate"
#   }
  
# }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
