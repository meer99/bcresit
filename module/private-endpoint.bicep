targetScope = 'resourceGroup'

param name string
param location string
param vnetName string
param subnetName string
param privateLinkResourceId string
param groupId string
param tags object

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' existing = {
  name: subnetName
  parent: vnet
}

resource pe 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    subnet: {
      id: subnet.id
    }
    privateLinkServiceConnections: [
      {
        name: '${name}-pls'
        properties: {
          privateLinkServiceId: privateLinkResourceId
          groupIds: [
            groupId
          ]
          requestMessage: 'Requested by Bicep deployment'
        }
      }
    ]
  }
}

output privateEndpointId string = pe.id
