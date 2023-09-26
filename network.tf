##
##  VNET Configuration 
##

resource "azurerm_virtual_network" "vnet-netSvcs"  {# Change for prefered name
  name                = local.moduleVars.netSvcsVnet 
  provider            = azurerm.sub01
  location            = local.moduleVars.location
  resource_group_name = azurerm_resource_group.rg-netSvcs.name
  address_space       = ["172.29.0.0/23"] # Change for customer address prefix
  dns_servers         = ["4.2.2.2", "8.8.8.8"] # Change this for customer DNS servers
   
  tags = local.tagsConnHigh


}

##
##  Subnet Configuration 
##

resource "azurerm_subnet" "snet-azureFirewallSubnet" { # Can't be changed
  name                 = "AzureFirewallSubnet" # Can't be changed
  provider             = azurerm.sub01
  resource_group_name  = azurerm_resource_group.rg-netSvcs.name
  virtual_network_name = azurerm_virtual_network.vnet-netSvcs.name
  address_prefixes     = ["172.29.0.0/25"]
}
resource "azurerm_subnet" "snet-gatewaySubnet" { # Can't be changed
  name                 = "GatewaySubnet" # Can't be changed
  provider             = azurerm.sub01
  resource_group_name  = azurerm_resource_group.rg-netSvcs.name
  virtual_network_name = azurerm_virtual_network.vnet-netSvcs.name
  address_prefixes     = ["172.29.0.128/25"] # Change for customer address prefix
}

resource "azurerm_subnet" "snet-azureBastionSubnet" { # Can't be changed
  name                 = "AzureBastionSubnet" # Can't be changed
  provider             = azurerm.sub01
  resource_group_name  = azurerm_resource_group.rg-netSvcs.name
  virtual_network_name = azurerm_virtual_network.vnet-netSvcs.name
  address_prefixes     = ["172.29.1.0/25"] # Change for customer address prefix
}



##
##  Route Table
##  Control routing of inbound traffic forcing it via the Azure firewall (e.g. from ExpressRoute, VPN gateways etc)
##

resource "azurerm_route_table" "rt-netSvcs01" {  # Can't be changed
  name                          = "rt-${azurerm_virtual_network.vnet-netSvcs.name}" # Can't be changed
  provider                      = azurerm.sub01
  location                      = local.moduleVars.location
  resource_group_name           = azurerm_resource_group.rg-netSvcs.name # Can't be changed
  disable_bgp_route_propagation = false

  route {
    name                   = "route-${data.azurerm_virtual_network.mgmtSvcs.name}" # Can't be changed
    address_prefix         = data.azurerm_virtual_network.mgmtSvcs.address_space[0] # Can't be changed
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.coreFw.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "route-${data.azurerm_virtual_network.idSvcs.name}" # Can't be changed
    address_prefix         = data.azurerm_virtual_network.idSvcs.address_space[0] # Can't be changed
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.coreFw.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "route-${data.azurerm_virtual_network.prodSvcs.name}"
    address_prefix         = data.azurerm_virtual_network.prodSvcs.address_space[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.coreFw.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "route-${data.azurerm_virtual_network.devSvcs.name}"
    address_prefix         = data.azurerm_virtual_network.devSvcs.address_space[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.coreFw.ip_configuration[0].private_ip_address
  }

   route {
    name                   = "route-${data.azurerm_virtual_network.devSvcs02.name}"
    address_prefix         = data.azurerm_virtual_network.devSvcs02.address_space[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.coreFw.ip_configuration[0].private_ip_address
  }
  
  
  tags = local.tagsConnHigh

}

##
##  Route Table Association
##

resource "azurerm_subnet_route_table_association" "routeAssoc01" {
  provider       = azurerm.sub01
  subnet_id      = azurerm_subnet.snet-gatewaySubnet.id
  route_table_id = azurerm_route_table.rt-netSvcs01.id
}

##
##  Diagnostic Confiuguration 
##

resource "azurerm_monitor_diagnostic_setting" "diagnosticSettingsLogAnalytics-netSvcs" {
  name                           = "logAnalytics"
  target_resource_id             = azurerm_virtual_network.vnet-netSvcs.id
  log_analytics_destination_type = "AzureDiagnostics"
  log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.log-telemetry01.id

  enabled_log {

    category_group = "allLogs"
    retention_policy {
      enabled = false
    }
  }
  metric {
    category = "AllMetrics"
    retention_policy {
      enabled = false
    }
  }
  lifecycle {
    ignore_changes = [
      log_analytics_destination_type
    ]
  }
}