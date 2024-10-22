using 'cloud-nss-web.bicep'

// Define the 'param' values below

// Found under Log Analytics workspace -> your workspace -> Overview -> Resource group
param resourceGroup = 'ahmadnss'

// The name of your Log Analytics workspace
param workspaceName = 'ahmadnss'

// Found under Log Analytics workspace -> your workspace -> Overview -> JSON View -> "location": (i.e. useast)
param location = 'Central India'

// Found under Log Analytics workspace -> your workspace -> Overview -> Subscription ID
param subscriptionId = '88ad672d-0da6-44d2-ac3e-79f34c2acfae'

// Found under Log Analytics workspace -> your workspace -> Overview -> Workspace ID
param workspaceId = 'f2c740be-f4b1-40bb-b4d2-cff39f137ca6'

// The name you want to provide the Data Collection Endpoint that the template will create
param dceName = 'dce-sentinel-cloud-web'

// The name you want to provide the Data Collection Rule that the template will create
param dcrName = 'dcr-sentinel-cloud-web'
