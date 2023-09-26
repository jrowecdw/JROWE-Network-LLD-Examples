


locals {

  envPrefixes = {
    sqlDbPrefix = "sqldb-"
    rgPrefix      = "rg-"
    kvPrefix      = "kv-"
    stgPrefix     = "stgbruns"
    vnetPrefix    = "vnet-"
    snetPrefix    = "snet-"
    pepPrefix     = "pep"
    pscPrefix     = "pep"
    appSvcPlanPrefix = "asp"
    webAppPrefix  = "web"
    vnetPrefix = "vnet-"
    snetPrefix = "snet-"
    exprCircuitPrefix = "erc-"
    pipPrefix = "pip-"
    vpnGwPrefix = "vpn-"
    ipPrePrefix = "ippre-"
    azfwPrefix = "afw-"
    azfwPolicyPrefix = "afwp-"
    bastionPrefix = "bastion-"
    keyVaultPrefix = "kv-"
    storagePrefix = "stgbdb"
    logPrefix = "log-"
    vmPrefix = "vm-"
    vmNicPrefix = "nic-"
    vmDiskPrefix = "dsk-"
    ipconfigPrefix = "config-"
    usrMgdIdPrefix = "umid-"
    rsvPrefix = "rsv-"
    privDnsResPrefix = "dnspr-"
    nsgPrefix = "nsg-"
    ipgPrefix = "ipg-"
   }

  envSuffixes = {
    connEnvSuffix    = "-conn-uks"
    connEnvStgSuffix = "connuks"
    mgmtEnvSuffix    = "-mgmt-uks"
    mgmtEnvStgSuffix = "mgmtuks"
    idEnvSuffix    = "-id-uks"
    idEnvStgSuffix = "iduks"
    prodEnvSuffix    = "-prod-uks"
    prodEnvStgSuffix = "produks"
    devEnvSuffix    = "-dev-uks"
    devEnvStgSuffix = "devuks"
  }

}
