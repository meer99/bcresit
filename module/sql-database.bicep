targetScope = 'resourceGroup'

param name string
param serverName string
param location string
param tags object

resource sqlDb 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: '${serverName}/${name}'
  location: location
  tags: tags
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 10
  }
  properties: {
    maxSizeBytes: 5368709120
  }
}

output databaseId string = sqlDb.id
