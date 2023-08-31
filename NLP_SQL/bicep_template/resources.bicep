// Define input parameters
param sqlServerName string
param sqlDatabaseName string
param openAIResourceName string
param location string
param speechServiceName string

// Create SQL Server resource
resource sqlServer 'Microsoft.Sql/servers@2022-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: '<admin name>' // Set the administrator login for the SQL Server
    administratorLoginPassword: '<password>' // Set the administrator login password for the SQL Server
  }
}

// Create SQL Database resource
resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-11-01-preview' = {
  parent: sqlServer // Set the parent resource to the SQL Server
  name: sqlDatabaseName // Set the name of the SQL Database
  location: location  // Set the location of the SQL Database
}

// Create Speech Service resource
resource speechService 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: speechServiceName // Set the name of the Speech Service
  location: location // Set the location of the Speech Service
  kind: 'SpeechServices' // Set the kind of the Speech Service to SpeechServices
  sku: {
    name: 'S0' // Set the SKU name to S0
    tier: 'Standard' // Set the SKU tier to Standard
  }
  properties: {
    customSubDomainName: speechServiceName // Set the custom subdomain name for the Speech Service
  }
  
  identity: {
    type: 'SystemAssigned' // Enable managed identity for the Speech Service
  }
}

// Create OpenAI resource
resource open_ai 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: openAIResourceName // Set the name of the OpenAI resource
  location: location // Set the location of the OpenAI resource
  kind: 'OpenAI' // Set the kind of the OpenAI resource to OpenAI
  sku: {
    name: 'S0' // Set the SKU name to S0
  }
  properties: {
    apiProperties: {
      endpoint: 'https://${openAIResourceName}.openai.azure.com/'  // Set the endpoint for the OpenAI resource   
    }
  }
}
  
