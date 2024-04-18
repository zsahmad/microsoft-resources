 /* 
This creates both the DCR and DCE's needed to ingest data into Sentinel from Zscaler's Cloud NSS capability. 
Please replace any references to workspace names or resource groups with your deployment details.
Steps needed to deploy:
1. Create an App Registration as per the Deployment Guide or Storylane demo
2. Run this script from Azure CLI using the following command:

    az stack group create --name cloud-nss-casbfilesharing --resource-group rg-sentinel-cloud-casbfilesharing --template-file ./cloud-nss-casbfilesharing.bicep --deny-settings-mode 'none'

  You will be prompted for parameters such as the resource group name and workspace id. You can enter ? and press enter to get a description of where to find each item.
  
  Alternatively, you can specify these parameters ahead of time by populating the cloud-nss-casbfilesharing.bicepparams file and running the following command in Azure CLI to deploy:

    az stack group create --name cloud-nss-casbfilesharing --resource-group rg-sentinel-cloud-casbfilesharing --parameters cloud-nss-casbfilesharing.bicepparam --deny-settings-mode 'none'

3. Go to the DCR this bicep template creates -> IAM -> Add this DCR as a Monitoring Metrics Publisher for the App Registration you created earlier.
4. Configure your Cloud NSS feed in the Zscaler Portal. You can retrieve the feed API URL using the following command in Azure CLI:

    az stack group show -g rg-sentinel-cloud-casbfilesharing -n cloud-nss-casbfilesharing --query outputs.api_url

5. If you ever need to delete the deployment, you can run the following command from Azure CLI:

    az stack group delete --name cloud-nss-casbfilesharing --resource-group rg-sentinel-cloud-casbfilesharing --delete-resources

*/ 
// These resources need to be pre-configured
@description('Found under Log Analytics workspace -> your workspace -> Overview -> Resource group')
param resourceGroup string // Found under Log Analytics workspace -> your workspace -> Overview -> Resource group
@description('The name of your Log Analytics workspace')
param workspaceName string
@description('Found under Log Analytics workspace -> your workspace -> Overview -> JSON View -> location. I.e. australiaeast')
param location string
@description('Found under Log Analytics workspace -> your workspace -> Overview -> Subscription ID')
param subscriptionId string
@description('Found under Log Analytics workspace -> your workspace -> Overview -> Workspace ID')
param workspaceId string

// These resources are configured through bicep
@description('Name of Data Collection Endpoint the template will create')
param dceName string
@description('Name of the Data Collection Rule the template will create')
param dcrName string

resource dce 'Microsoft.Insights/dataCollectionEndpoints@2022-06-01' = {
  properties: {
    configurationAccess: {}
    logsIngestion: {}
    networkAcls: {
      publicNetworkAccess: 'Enabled'
    }
  }
  location: location
  name: dceName
}

resource dcr 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  properties: {
    dataCollectionEndpointId: dce.id
    streamDeclarations: {
      'Custom-nss_casbfilesharing_CL': {
        columns: [
	{
	  name: 'sourcetype'
	  type: 'string'
	}
	{
	  name: 'TimeGenerated'
	  type: 'datetime'
	}
	{
	  name: 'vendor'
	  type: 'string'
	}
	{
	  name: 'product'
	  type: 'string'
	}
	{
	  name: 'version'
	  type: 'string'
	}
	{
	  name: 'Severity'
	  type: 'string'
	}
	{
	  name: 'name'
	  type: 'string'
	}
	{
	  name: 'deviceEventClassId'
	  type: 'string'
	}
	{
	  name: 'act'
	  type: 'string'
	}
	{
	  name: 'cs1'
	  type: 'string'
	}
	{
	  name: 'cs1Label'
	  type: 'string'
	}
	{
	  name: 'fileModificationTime'
	  type: 'string'
	}
	{
	  name: 'start'
	  type: 'string'
	}
	{
	  name: 'filedownloadtimems'
	  type: 'string'
	}
	{
	  name: 'filescantimems'
	  type: 'string'
	}
	{
	  name: 'fsize'
	  type: 'string'
	}
	{
	  name: 'deviceExternalId'
	  type: 'string'
	}
	{
	  name: 'collabscope'
	  type: 'string'
	}
	{
	  name: 'company'
	  type: 'string'
	}
	{
	  name: 'datacenter'
	  type: 'string'
	}
	{
	  name: 'datacentercity'
	  type: 'string'
	}
	{
	  name: 'datacentercountry'
	  type: 'string'
	}
	{
	  name: 'department'
	  type: 'string'
	}
	{
	  name: 'cs2'
	  type: 'string'
	}
	{
	  name: 'cs2Label'
	  type: 'string'
	}
	{
	  name: 'cs3'
	  type: 'string'
	}
	{
	  name: 'cs3Label'
	  type: 'string'
	}
	{
	  name: 'cs4'
	  type: 'string'
	}
	{
	  name: 'cs4Label'
	  type: 'string'
	}
	{
	  name: 'extcollabnames'
	  type: 'string'
	}
	{
	  name: 'extownername'
	  type: 'string'
	}
	{
	  name: 'fileId'
	  type: 'string'
	}
	{
	  name: 'fileHash'
	  type: 'string'
	}
	{
	  name: 'fname'
	  type: 'string'
	}
	{
	  name: 'filePath'
	  type: 'string'
	}
	{
	  name: 'fileType'
	  type: 'string'
	}
	{
	  name: 'request'
	  type: 'string'
	}
	{
	  name: 'dhost'
	  type: 'string'
	}
	{
	  name: 'intcollabnames'
	  type: 'string'
	}
	{
	  name: 'flexString1Label'
	  type: 'string'
	}
	{
	  name: 'flexString1'
	  type: 'string'
	}
	{
	  name: 'flexString2Label'
	  type: 'string'
	}
	{
	  name: 'flexString2'
	  type: 'string'
	}
	{
	  name: 'odlpdictnames'
	  type: 'string'
	}
	{
	  name: 'odlpenginenames'
	  type: 'string'
	}
	{
	  name: 'oextcollabnames'
	  type: 'string'
	}
	{
	  name: 'oextownername'
	  type: 'string'
	}
	{
	  name: 'ofileid'
	  type: 'string'
	}
	{
	  name: 'efullurl'
	  type: 'string'
	}
	{
	  name: 'ehostname'
	  type: 'string'
	}
	{
	  name: 'ointcollabnames'
	  type: 'string'
	}
	{
	  name: 'orulelabel'
	  type: 'string'
	}
	{
	  name: 'otenant'
	  type: 'string'
	}
	{
	  name: 'ouser'
	  type: 'string'
	}
	{
	  name: 'cs5'
	  type: 'string'
	}
	{
	  name: 'cs5Label'
	  type: 'string'
	}
	{
	  name: 'cs6'
	  type: 'string'
	}
	{
	  name: 'cs6Label'
	  type: 'string'
	}
	{
	  name: 'agentSeverity'
	  type: 'string'
	}
	{
	  name: 'tenant'
	  type: 'string'
	}
	{
	  name: 'threatname'
	  type: 'string'
	}
	{
	  name: 'deviceCustomDate1Label'
	  type: 'string'
	}
	{
	  name: 'deviceCustomDate1'
	  type: 'string'
	}
	{
	  name: 'dtz'
	  type: 'string'
	}
	{
	  name: 'upload_doctypename'
	  type: 'string'
	}
	{
	  name: 'suser'
	  type: 'string'
	}
      ] 
    }
  }
  dataSources: {}
  destinations: {
    logAnalytics: [
      {
        workspaceResourceId: resourceId(subscriptionId, resourceGroup, 'microsoft.operationalinsights/workspaces', workspaceName)
        name: workspaceId
      }
    ]
  }
  dataFlows: [
    {
      streams: [
        'Custom-nss_casbfilesharing_CL'
      ]
      destinations: [
        workspaceId
      ]
        transformKql: 'source | project TimeGenerated, DeviceVendor=tostring(vendor), DeviceProduct=tostring(product), DeviceVersion=tostring(version), LogSeverity=tostring(Severity), Activity=tostring(name), DeviceEventClassID=tostring(deviceEventClassId), DeviceAction=tostring(act), DeviceCustomString1=tostring(cs1), DeviceCustomString1Label=tostring(cs1Label), FileModificationTime=tostring(fileModificationTime), FileSize=toint(fsize), deviceExternalId=tostring(deviceExternalId), DeviceCustomString2=tostring(cs2), DeviceCustomString2Label=tostring(cs2Label), DeviceCustomString3=tostring(cs3), DeviceCustomString3Label=tostring(cs3Label), DeviceCustomString4=tostring(cs4), DeviceCustomString4Label=tostring(cs4Label), FileID=tostring(fileId), FileHash=tostring(fileHash), FileName=tostring(fname), FilePath=tostring(filePath), FileType=tostring(fileType), DestinationHostName=tostring(dhost), FlexString1Label=tostring(flexString1Label), FlexString1=tostring(flexString1), FlexString2Label=tostring(flexString2Label), FlexString2=tostring(flexString2), DeviceCustomString5=tostring(cs5), DeviceCustomString5Label=tostring(cs5Label), DeviceCustomString6=tostring(cs6), DeviceCustomString6Label=tostring(cs6Label), DeviceCustomDate1Label=tostring(deviceCustomDate1Label), DeviceCustomDate1=tostring(deviceCustomDate1), DeviceTimeZone=tostring(dtz), SourceUserName=tostring(suser), AdditionalExtensions = strcat("start=",start,";filedownloadtimems=",filedownloadtimems,";filescantimems=",filescantimems,";collabscope=",collabscope,";company=",company,";datacenter=",datacenter,";datacentercity=",datacentercity,";datacentercountry=",datacentercountry,";department=",department,";extcollabnames=",extcollabnames,";extownername=",extownername,";request=",request,";intcollabnames=",intcollabnames,";odlpdictnames=",odlpdictnames,";odlpenginenames=",odlpenginenames,";oextcollabnames=",oextcollabnames,";oextownername=",oextownername,";ofileid=",ofileid,";efullurl=",efullurl,";ehostname=",ehostname,";ointcollabnames=",ointcollabnames,";orulelabel=",orulelabel,";otenant=",otenant,";ouser=",ouser,";agentSeverity=",agentSeverity,";tenant=",tenant,";threatname=",threatname,";upload_doctypename=",upload_doctypename)'

        outputStream: 'Microsoft-CommonSecurityLog'
      }
  
      // 
    ]
  }
  location: location
  name: dcrName
}

// Store feed api url in template output
output api_url string = '${dce.properties.logsIngestion.endpoint}/dataCollectionRules/${dcr.properties.immutableId}/streams/Custom-nss_casbfilesharing_CL?api-version=2021-11-01-preview'