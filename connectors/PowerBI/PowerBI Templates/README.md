# PoC Dashboards for EAS : 
The implementation is far from polished, but it works. Treat it as a PoC level of development - I'd welcome any improvement contributions.

# Installation 
1) Install PowerBI Desktop
2) Requires connector found elsewhere in this repo.
3) Upon first Run you'll be required to enter your EAS Repository-ID and tenantID as Parameters which will be used in the data connections queries
4) You'll be prompted multiple times for 'Anonymous' Authentication - Click OK for each (1 per query)

## Troubleshooting

1) If PowerBI states incorrect credentials, double check both the credentials and the RepositoryID - as either may generate this error.

# Using the PowerBI Dashboards

1) PowerBI doesn't allow for ambiguous data relationships, which the Essential ontology does allow for
	Essential view's actually dont encounter this issues as each report (or 'view') creates and resolves the data relationship path at the point of developing the view in XSLT.
	
2) What this means is that PowerBI will disable paths that would otherwise create loops. For instance
	* The Site class cannot be linked to both the Application_Provider class and Physical_Process Class simultaneously if there's a loop further in the data model' 
				(PowerBI wouldn't know whether, when using site you wanted the site of Application_Provider or Physical_Process')
3)  There's a few approaches that can resolve this'
	* For Simple Dashboards it's relatively easy to fix, disable the paths you don't want and enable the path you do
	* Also futher data manipulation (e.g. merging of tables using, for instance, Left.Joins) to resolve ambiguity and leave data pathways without loops

	
## Examples 

![Alt Text](https://github.com/{user}/{repo}/raw/master/path/to/image.gif)


