targetScope = 'resourceGroup'

param name string
param location string
param adminLogin string
@secure()
param adminPassword string
param tags object

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    publicNetworkAccess: 'Disabled'
    minimalTlsVersion: '1.2'
  }
}

output serverId string = sqlServer.id
