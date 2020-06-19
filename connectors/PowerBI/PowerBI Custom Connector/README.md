# Health Warnings/Disclaimer : 

1) The implementation is far from polished, but it works. Treat it as a PoC level of development - I'd welcome any improvement contributions.
2) This connector doesn't make any attempt to control secrets - the credentials will be embedded in the .mez file - as such the connector should not be freely distributed as it will contain sensitive credentials. Other Patterns exist for connecting without this risk (see )

# Getting Started 
For this Custom Connector you'll need to 

1) Install Visual Studio (free version will work)
2) Then follow instructions here https://github.com/Microsoft/DataConnectors (replicated below for ease)
3) Insert the secrets (api-key/user/pass etc.)

## Quickstart (this is a copy of the text from link above)

1. Install the [Power Query SDK](https://aka.ms/powerquerysdk) from the Visual Studio Marketplace
2. Create a new Data Connector project
3. Copy the code from this project *.pq files across 
4. Inject your company/user secrets
5. Build the project to produce an extension file
6. Copy the extension file into the `[Documents]\Power BI Desktop\Custom Connectors` directory
7. Open Power BI Desktop

Note, to load extensions during development, you will need to lower the security level for extensions in Power BI Desktop to enable loading unsigned/uncertified connectors.

1. Go to File | Options and settings | Options
2. Go the Security tab
3. Under *Data Extensions*, select *Allow any extension to load without warning or validation*
4. Restart Power BI Desktop