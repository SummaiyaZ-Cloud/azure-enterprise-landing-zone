@description('Azure region where networking resources will be deployed')
param location string

@description('Deployment environment, such as dev or prod')
param environment string

@description('Address space for the hub virtual network')
param hubAddressPrefix string

@description('Address space for the spoke virtual network')
param spokeAddressPrefix string

@description('Address prefix for the hub management subnet')
param hubManagementSubnetPrefix string

@description('Address prefix for the spoke application subnet')
param spokeAppSubnetPrefix string

resource hubVnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet-hub-${environment}'
  location: location
    tags: {
    Environment: environment
    ManagedBy: 'Bicep'
    Project: 'EnterpriseLandingZone'
    CostCenter: 'CloudLab'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        hubAddressPrefix
      ]
    }
  }
}

resource spokeVnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet-spoke-${environment}'
  location: location
    tags: {
    Environment: environment
    ManagedBy: 'Bicep'
    Project: 'EnterpriseLandingZone'
    CostCenter: 'CloudLab'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        spokeAddressPrefix
      ]
    }
  }
}
resource hubManagementSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: hubVnet
  name: 'snet-management'
  properties: {
    addressPrefix: hubManagementSubnetPrefix
  }
}
resource spokeAppSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: spokeVnet
  name: 'snet-app'
  properties: {
    addressPrefix: spokeAppSubnetPrefix
  }
}
resource hubToSpokePeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  parent: hubVnet
  name: 'peer-hub-to-spoke-${environment}'
  dependsOn: [
  hubManagementSubnet
  spokeAppSubnet
]
  properties: {
    remoteVirtualNetwork: {
      id: spokeVnet.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
resource spokeToHubPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-05-01' = {
  parent: spokeVnet
  name: 'peer-spoke-to-hub-${environment}'
  dependsOn: [
  hubManagementSubnet
  spokeAppSubnet
]
  properties: {
    remoteVirtualNetwork: {
      id: hubVnet.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
