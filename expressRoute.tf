resource "azurerm_express_route_circuit" "exprCircuit01" {
  name                = "${local.moduleVars.exprCircuit}"
  provider            = azurerm.sub01
  resource_group_name  = azurerm_resource_group.rg-netSvcs.name
  location            = "${local.moduleVars.location}"
  service_provider_name = "Equinix"
  peering_location      = "London"
  bandwidth_in_mbps     = 500

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }
  
  tags = local.tagsConnHigh
}

resource "azurerm_express_route_circuit_peering" "exprPeerAzPriUks" {
  provider                      = azurerm.sub01
  peering_type                  = "AzurePrivatePeering"
  express_route_circuit_name    = azurerm_express_route_circuit.exprCircuit01.name
  resource_group_name           = azurerm_resource_group.rg-netSvcs.name
  peer_asn                      = 60788
  primary_peer_address_prefix   = "100.64.0.32/30"
  secondary_peer_address_prefix = "100.64.0.36/30"
  ipv4_enabled                  = true
  vlan_id                       = 100

  shared_key = data.azurerm_key_vault_secret.secret-exprRoutePriBgpKey.value
  

  
}

resource "azurerm_virtual_network_gateway_connection" "exprConnUks" {
  provider                      = azurerm.sub01
  location            = "${local.moduleVars.location}"
  name                             = "conn-exprRoute-gamma-01"
  resource_group_name  = azurerm_resource_group.rg-netSvcs.name
  type = "ExpressRoute"
  express_route_circuit_id       = azurerm_express_route_circuit.exprCircuit01.id
  virtual_network_gateway_id = azurerm_virtual_network_gateway.exprGw.id
  
  tags = local.tagsConnHigh

resource "azurerm_monitor_diagnostic_setting" "diagnosticSettingsLogAnalytics-expressRouteConn" {
  name                           = "logAnalytics"
  target_resource_id             = azurerm_virtual_network_gateway_connection.exprConnUks.id
  log_analytics_destination_type = "AzureDiagnostics"
  log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.log-telemetry01.id

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

resource "azurerm_monitor_diagnostic_setting" "diagnosticSettingsLogAnalytics-expressRouteCircuit" {
  name                           = "logAnalytics"
  target_resource_id             = azurerm_express_route_circuit.exprCircuit01.id
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