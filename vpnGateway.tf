# Pubic IP Address for VPN Gateway
resource "azurerm_public_ip" "exprGwPip" {
  name                = "${local.moduleVars.exprGwPip}-01"
  provider            = azurerm.sub01
  location            = "${local.moduleVars.location}"
  resource_group_name = azurerm_resource_group.rg-netSvcs.name
  sku                 = "Standard"
  allocation_method   = "Static"
  zones = [1, 2, 3]

  tags = local.tagsConnHigh

}

# VPN Gateway
resource "azurerm_virtual_network_gateway" "exprGw" {
  name                = "${local.moduleVars.exprGwVng}"
  provider            = azurerm.sub01
  location            = "${local.moduleVars.location}"
  resource_group_name = azurerm_resource_group.rg-netSvcs.name

  type     = "ExpressRoute"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "ErGw1AZ"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.exprGwPip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.snet-gatewaySubnet.id
  }

 tags = local.tagsConnHigh

  
}

resource "azurerm_monitor_diagnostic_setting" "diagnosticSettingsLogAnalytics-exprGw" {
  name                           = "logAnalytics"
  target_resource_id             = azurerm_virtual_network_gateway.exprGw.id
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


