

resource "azurerm_resource_group" "rg-netSvcs" {
  provider = azurerm.sub01
  name     = "${local.moduleVars.netSvcsRg}"
  location = "${local.moduleVars.location}"

  tags = local.tagsConnHigh

}

resource "azurerm_resource_group" "rg-platformSvcs" {
  provider = azurerm.sub01
  name     = "${local.moduleVars.platformSvcsRg}"
  location = "${local.moduleVars.location}"

  tags = local.tagsConnHigh

  
}

resource "azurerm_resource_group" "rg-bastion" {
  provider = azurerm.sub01
  name     = "${local.moduleVars.bastionRg}"
  location = "${local.moduleVars.location}"

  tags = local.tagsConnHigh


}

# Empty at this point, most IPGs are in UKS
resource "azurerm_resource_group" "rg-ipGroups" {
  provider = azurerm.sub01
  name     = "${local.moduleVars.ipGroupsRg}"
  location = "${local.moduleVars.location}"

 tags = local.tagsConnHigh


}

