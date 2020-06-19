// Use this file to write queries to test your data connector
let
    //update <tenantID> and <repo-id> with appropriate values      
    result = EAS_Connector_v0.1.Contents("https://<tenantID>.essentialintelligence.com/api/essential-core/v1/repositories/<repo-id>/business-domains")
in
    result