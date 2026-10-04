using '../main.bicep'

param environment = 'dev'

param hubAddressPrefix = '10.0.0.0/16'

param spokeAddressPrefix = '10.1.0.0/16'

param hubManagementSubnetPrefix = '10.0.1.0/24'

param spokeAppSubnetPrefix = '10.1.1.0/24'
