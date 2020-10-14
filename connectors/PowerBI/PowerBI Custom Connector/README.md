# Health Warnings/Disclaimer : 

1) The implementation is far from polished, but it works. Treat it as a PoC level of development - I'd welcome any improvement contributions.
2) This connector doesn't make any attempt to control secrets - the credentials will be embedded in the .mez file - as such the connector should not be freely distributed as it will contain sensitive credentials. Other Patterns exist for connecting without this risk.

# Getting Started 
For this Custom Connector you'll need to 

1) Install Visual Studio (free version will work)
2) Then follow instructions here https://github.com/Microsoft/DataConnectors (replicated below for ease)

## Quickstart (this is a copy of the text from link above)

1. Install the [Power Query SDK](https://aka.ms/powerquerysdk) from the Visual Studio Marketplace
2. Create a new Data Connector project
3. Copy the code from this project *.pq files across 
4. Inject your company/user secrets into the appropriate part of the code
```
api_key = "xxx";   //API Key
vusername = "xxx"; //EAS Cloud username of local account (non-SAML) with appropriate priveleges to repo/data
vpassword = "xxx"; //Associated password to the above Account
tenantID = "xxx";  //EAS Tenant Name 
```
5. Build the project to produce an extension file (.mez file)
6. Copy the extension file into the `[Documents]\Power BI Desktop\Custom Connectors` directory
7. Open Power BI Desktop
Either
8.a Go into Transform data (don't use "get data" on the main PowerBI screen)
8.b Use Manage Parameters > New Parameters to create two paramaters and populate with the correct values. - these parameters are used in query example below.
* tenantID 
* Production-Repo-ID
8.c Create a New Source > Blank Query 
8.d Open Advanced Editor on this query and paste the following example query
```
let
    class = "Composite_Application_Provider",
    Source = EAS_Connector_v0.1.Contents("https://" & #"tenantID" & ".essentialintelligence.com/api/essential-utility/v2/repositories/" & #"Production-Repo-ID" & "/classes/" & class &  "/instances"),
    instances = Source[instances]
in
    instances
```
or
8.a Download and open the PowerBI PoC Template from elsewhere in this repo for a extensive list of queries and relationships and customise as required

Note, to load extensions during development, you will need to lower the security level for extensions in Power BI Desktop to enable loading unsigned/uncertified connectors.

1. Go to File | Options and settings | Options
2. Go the Security tab
3. Under *Data Extensions*, select *Allow any extension to load without warning or validation*
4. Restart Power BI Desktop
