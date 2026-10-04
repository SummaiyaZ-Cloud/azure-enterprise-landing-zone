@description('Azure region where monitoring resources will be deployed')
param location string

@description('Deployment environment, such as dev or prod')
param environment string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'law-landingzone-${environment}'
  location: location
    tags: {
    Environment: environment
    ManagedBy: 'Bicep'
    Project: 'EnterpriseLandingZone'
    CostCenter: 'CloudLab'
  }
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}
