# Edit these

variable "location" {
  type    = string
  default = "uksouth"
}

variable "platformSvcsRgName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "platformSvcs"
}

variable "networkSvcsRgName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "netSvcs"
}

variable "bastionRgName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "bastion01"
}

variable "ipGroupsRgName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "ipGroups"
}

variable "netSvcsVnetName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "netSvcs"
}

variable "exprCircuitName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "equinixLondon01"
}

variable "exprGwName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "exprGw01"
}

variable "coreFwName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "coreFw01"
}

variable "azfwPolicyName" {
  description = "Resource group name for network services like firewalls and VPN gateways"
  type        = string
  default     = "policy01"
}

variable "pip01BastionMgmtInstName" {
  description = "Public IP address for bastion mgmt, friendly name"
  type        = string
  default     = "bastionMgmt"
}

variable "bastionMgmtInstName" {
  description = "Bastion mgmt instancefriendly name"
  type        = string
  default     = "mgmt01"
}

locals {

  moduleVars = {
    location             = var.location
    platformSvcsRg       = "${local.envPrefixes.rgPrefix}${var.platformSvcsRgName}${local.envSuffixes.connEnvSuffix}"
    netSvcsRg            = "${local.envPrefixes.rgPrefix}${var.networkSvcsRgName}${local.envSuffixes.connEnvSuffix}"
    bastionRg            = "${local.envPrefixes.rgPrefix}${var.bastionRgName}${local.envSuffixes.connEnvSuffix}"
    ipGroupsRg           = "${local.envPrefixes.rgPrefix}${var.ipGroupsRgName}${local.envSuffixes.connEnvSuffix}"
    netSvcsVnet          = "${local.envPrefixes.vnetPrefix}${var.netSvcsVnetName}${local.envSuffixes.connEnvSuffix}"
    exprCircuit          = "${local.envPrefixes.exprCircuitPrefix}${var.exprCircuitName}${local.envSuffixes.connEnvSuffix}"
    exprGwPip            = "${local.envPrefixes.pipPrefix}${var.exprGwName}${local.envSuffixes.connEnvSuffix}"
    exprGwVng            = "${local.envPrefixes.vpnGwPrefix}${var.exprGwName}${local.envSuffixes.connEnvSuffix}"
    ipPreCoreFw          = "${local.envPrefixes.ipPrePrefix}${var.coreFwName}${local.envSuffixes.connEnvSuffix}"
    pip01CoreFw          = "${local.envPrefixes.pipPrefix}${var.coreFwName}-01${local.envSuffixes.connEnvSuffix}"
    pip02CoreFw          = "${local.envPrefixes.pipPrefix}${var.coreFwName}-02${local.envSuffixes.connEnvSuffix}"
    pip03CoreFw          = "${local.envPrefixes.pipPrefix}${var.coreFwName}-03${local.envSuffixes.connEnvSuffix}"
    pip04CoreFw          = "${local.envPrefixes.pipPrefix}${var.coreFwName}-04${local.envSuffixes.connEnvSuffix}"
    coreFw               = "${local.envPrefixes.azfwPrefix}${var.coreFwName}${local.envSuffixes.connEnvSuffix}"
    azfwPolicy           = "${local.envPrefixes.azfwPolicyPrefix}${var.azfwPolicyName}${local.envSuffixes.connEnvSuffix}"
    azfwPolicyGeneral    = "${local.envPrefixes.azfwPolicyPrefix}general01${local.envSuffixes.connEnvSuffix}"
    azfwPolicyProd       = "${local.envPrefixes.azfwPolicyPrefix}prodEnv${local.envSuffixes.connEnvSuffix}"
    azfwPolicyDev        = "${local.envPrefixes.azfwPolicyPrefix}devEnv${local.envSuffixes.connEnvSuffix}"
    pip01BastionMgmtInst = "${local.envPrefixes.pipPrefix}${var.pip01BastionMgmtInstName}${local.envSuffixes.connEnvSuffix}"
    bastionMgmtInst01    = "${local.envPrefixes.bastionPrefix}${var.bastionMgmtInstName}${local.envSuffixes.connEnvSuffix}"

    ipgAzureSubnets    = "${local.envPrefixes.ipgPrefix}azureSubnets${local.envSuffixes.connEnvSuffix}"
    ipgRfc1918networks = "${local.envPrefixes.ipgPrefix}rfc1918networks${local.envSuffixes.connEnvSuffix}"
    ipgDevIsolated     = "${local.envPrefixes.ipgPrefix}devIsolated${local.envSuffixes.connEnvSuffix}"
    ipgDmzExternal     = "${local.envPrefixes.ipgPrefix}dmzExternal${local.envSuffixes.connEnvSuffix}"
    ipgDmzInternal     = "${local.envPrefixes.ipgPrefix}dmzInternal${local.envSuffixes.connEnvSuffix}"

    ipgHubshareWeb          = "${local.envPrefixes.ipgPrefix}hubshareWeb${local.envSuffixes.connEnvSuffix}"
    ipgHubShareSync         = "${local.envPrefixes.ipgPrefix}hubShareSync${local.envSuffixes.connEnvSuffix}"
    ipgHubShareSql          = "${local.envPrefixes.ipgPrefix}hubShareSql${local.envSuffixes.connEnvSuffix}"
    ipgSvfw02               = "${local.envPrefixes.ipgPrefix}svfw02${local.envSuffixes.connEnvSuffix}"
    ipgSvfa04               = "${local.envPrefixes.ipgPrefix}svfa04${local.envSuffixes.connEnvSuffix}"
    ipgSquid                = "${local.envPrefixes.ipgPrefix}squid${local.envSuffixes.connEnvSuffix}"
    ipgSsql04               = "${local.envPrefixes.ipgPrefix}ssql04${local.envSuffixes.connEnvSuffix}"
    ipgSwsus04              = "${local.envPrefixes.ipgPrefix}sSwsus04${local.envSuffixes.connEnvSuffix}"
    ipgSintappxml           = "${local.envPrefixes.ipgPrefix}sintappxml${local.envSuffixes.connEnvSuffix}"
    ipgSweb8                = "${local.envPrefixes.ipgPrefix}sweb8${local.envSuffixes.connEnvSuffix}"
    ipgSweb8db              = "${local.envPrefixes.ipgPrefix}sweb8db${local.envSuffixes.connEnvSuffix}"
    ipgExchangeOnline       = "${local.envPrefixes.ipgPrefix}exchangeOnline${local.envSuffixes.connEnvSuffix}"
    ipgZoom                 = "${local.envPrefixes.ipgPrefix}ipgZoom${local.envSuffixes.connEnvSuffix}"
    allLanSubnets           = "${local.envPrefixes.ipgPrefix}allLanSubnets${local.envSuffixes.connEnvSuffix}"
    exhybrid                = "${local.envPrefixes.ipgPrefix}exhybrid${local.envSuffixes.connEnvSuffix}"
    zscalerHub              = "${local.envPrefixes.ipgPrefix}zscalerHub${local.envSuffixes.connEnvSuffix}"
    zscalerEnforcementNodes = "${local.envPrefixes.ipgPrefix}zscalerEnforcementNodes${local.envSuffixes.connEnvSuffix}"

  }

   # Resource tag definitions
  tagsConnLow = {
    environment    = "connectivity"
    criticality    = "low"
    deployedVia    = "terraform"
    startupGroup   = "notApplicable"
    asrProtected   = "notApplicable"
    backupSchedule = "notApplicable"
    updateSchedule = "notApplicable"
  }
   tagsConnMedium = {
    environment    = "connectivity"
    criticality    = "medium"
    deployedVia    = "terraform"
    startupGroup   = "notApplicable"
    asrProtected   = "notApplicable"
    backupSchedule = "notApplicable"
    updateSchedule = "notApplicable"
  }
   tagsConnHigh = {
    environment    = "connectivity"
    criticality    = "high"
    deployedVia    = "terraform"
    startupGroup   = "notApplicable"
    asrProtected   = "notApplicable"
    backupSchedule = "notApplicable"
    updateSchedule = "notApplicable"
  }
  

}




