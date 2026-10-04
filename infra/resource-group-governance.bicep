targetScope = 'resourceGroup'

@description('Resource ID of the custom Environment tag policy definition')
param policyDefinitionId string

@description('Deployment environment, such as dev or prod')
param environment string

resource requireEnvironmentTagAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: 'require-environment-tag-${environment}'
  properties: {
    displayName: 'Require Environment tag - ${environment}'
    description: 'Enforces the Environment tag within this landing zone resource group.'
    policyDefinitionId: policyDefinitionId
  }
}
