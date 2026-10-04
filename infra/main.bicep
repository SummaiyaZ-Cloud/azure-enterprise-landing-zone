@description('Azure region for the landing zone deployment')
param location string = 'eastus'

@description('Deployment environment')
@allowed([
  'dev'
  'prod'
])
param environment string

@description('Address space for the hub virtual network')
param hubAddressPrefix string

@description('Address space for the spoke virtual network')
param spokeAddressPrefix string

@description('Address prefix for the hub management subnet')
param hubManagementSubnetPrefix string

@description('Address prefix for the spoke application subnet')
param spokeAppSubnetPrefix string

module networking 'modules/networking.bicep' = {
  name: 'networking-${environment}'
  params: {
    location: location
    environment: environment
    hubAddressPrefix: hubAddressPrefix
    spokeAddressPrefix: spokeAddressPrefix
    hubManagementSubnetPrefix: hubManagementSubnetPrefix
    spokeAppSubnetPrefix: spokeAppSubnetPrefix
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: 'monitoring-${environment}'
  params: {
    location: location
    environment: environment
  }
}
