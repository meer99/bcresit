targetScope = 'resourceGroup'

param name string
param location string
param tags object

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    retentionInDays: 30
  }
}

output workspaceId string = workspace.id
