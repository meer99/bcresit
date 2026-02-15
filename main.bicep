targetScope = 'resourceGroup'

param location string
param environment string
param tags object

@description('Existing resource group name')
param resourceGroupName string

@description('Existing VNet name')
param vnetName string

@description('Existing subnet name for private endpoints')
param subnetName string

param containerAppsEnvName string
param containerRegistryName string
param containerAppJob1Name string
param containerAppJob2Name string
param sqlServerName string
param sqlDatabaseName string
param sqlAdminLogin string
@secure()
param sqlAdminPassword string
param userAssignedIdentityName string
param logAnalyticsWorkspaceName string

param privateEndpointAcrName string
param privateEndpointCaeName string
param privateEndpointSqlName string

module managedIdentity './module/managed-identity.bicep' = {
  name: 'managedIdentity'
  params: {
    name: userAssignedIdentityName
    location: location
    tags: tags
  }
}

module logAnalytics './module/log-analytics.bicep' = {
  name: 'logAnalytics'
  params: {
    name: logAnalyticsWorkspaceName
    location: location
    tags: tags
  }
}

module containerAppsEnv './module/container-app-env.bicep' = {
  name: 'containerAppsEnv'
  params: {
    name: containerAppsEnvName
    location: location
    logAnalyticsWorkspaceId: logAnalytics.outputs.workspaceId
    tags: tags
  }
}

module containerRegistry './module/container-registry.bicep' = {
  name: 'containerRegistry'
  params: {
    name: containerRegistryName
    location: location
    userAssignedIdentityId: managedIdentity.outputs.identityId
    tags: tags
  }
}

module sqlServer './module/sql-server.bicep' = {
  name: 'sqlServer'
  params: {
    name: sqlServerName
    location: location
    adminLogin: sqlAdminLogin
    adminPassword: sqlAdminPassword
    tags: tags
  }
}

module sqlDatabase './module/sql-database.bicep' = {
  name: 'sqlDatabase'
  params: {
    name: sqlDatabaseName
    serverName: sqlServerName
    location: location
    tags: tags
  }
}

module containerAppJob1 './module/container-app-job1.bicep' = {
  name: 'containerAppJob1'
  params: {
    name: containerAppJob1Name
    environmentId: containerAppsEnv.outputs.environmentId
    userAssignedIdentityId: managedIdentity.outputs.identityId
    tags: tags
  }
}

module containerAppJob2 './module/container-app-job2.bicep' = {
  name: 'containerAppJob2'
  params: {
    name: containerAppJob2Name
    environmentId: containerAppsEnv.outputs.environmentId
    userAssignedIdentityId: managedIdentity.outputs.identityId
    tags: tags
  }
}

module peAcr './module/private-endpoint.bicep' = {
  name: 'privateEndpointAcr'
  params: {
    name: privateEndpointAcrName
    location: location
    subnetName: subnetName
    vnetName: vnetName
    privateLinkResourceId: containerRegistry.outputs.registryId
    groupId: 'registry'
    tags: tags
  }
}

module peCae './module/private-endpoint.bicep' = {
  name: 'privateEndpointCae'
  params: {
    name: privateEndpointCaeName
    location: location
    subnetName: subnetName
    vnetName: vnetName
    privateLinkResourceId: containerAppsEnv.outputs.environmentId
    groupId: 'managedEnvironment'
    tags: tags
  }
}

module peSql './module/private-endpoint.bicep' = {
  name: 'privateEndpointSql'
  params: {
    name: privateEndpointSqlName
    location: location
    subnetName: subnetName
    vnetName: vnetName
    privateLinkResourceId: sqlServer.outputs.serverId
    groupId: 'sqlServer'
    tags: tags
  }
}

output deploymentContext object = {
  environment: environment
  resourceGroupName: resourceGroupName
}
