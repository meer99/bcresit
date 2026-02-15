param location string = resourceGroup().location
param environment string
param tags object = {}

param resourceGroupName string
param vnetName string
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

var hasSqlAdminPassword = !empty(sqlAdminPassword)

output parameterSnapshot object = {
	location: location
	environment: environment
	tags: tags
	resourceGroupName: resourceGroupName
	vnetName: vnetName
	subnetName: subnetName
	containerAppsEnvName: containerAppsEnvName
	containerRegistryName: containerRegistryName
	containerAppJob1Name: containerAppJob1Name
	containerAppJob2Name: containerAppJob2Name
	sqlServerName: sqlServerName
	sqlDatabaseName: sqlDatabaseName
	sqlAdminLogin: sqlAdminLogin
	hasSqlAdminPassword: hasSqlAdminPassword
	userAssignedIdentityName: userAssignedIdentityName
	logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
	privateEndpointAcrName: privateEndpointAcrName
	privateEndpointCaeName: privateEndpointCaeName
	privateEndpointSqlName: privateEndpointSqlName
}
