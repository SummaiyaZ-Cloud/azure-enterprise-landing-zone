using '../main.bicep'

param environment = 'prod'

param hubAddressPrefix = '10.10.0.0/16'

param spokeAddressPrefix = '10.11.0.0/16'

param hubManagementSubnetPrefix = '10.10.1.0/24'

param spokeAppSubnetPrefix = '10.11.1.0/24'
