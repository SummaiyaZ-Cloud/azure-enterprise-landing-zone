targetScope = 'subscription'

@description('Deployment environment, such as dev or prod')
param environment string

resource requireEnvironmentTag 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: 'require-environment-tag-${environment}'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Require Environment tag - ${environment}'
    description: 'Requires supported resources to include an Environment tag.'
    policyRule: {
      if: {
        field: 'tags[Environment]'
        exists: 'false'
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
