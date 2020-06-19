// This file contains your Data Connector logic
section EAS_Connector_v0.1;

//following variables contain sensitive information and should not be shared
//TODO - look to have a better way of handling credentials - consider Extension.CurrentCredential() function,
api_key = "xxx";   //API Key
vusername = "xxx"; //EAS Cloud username of local account (non-SAML) with appropriate priveleges to repo/data 
vpassword = "xxx"; //Associated password to the above User account
tenantID = "xxx";  //EAS Tenant Name 

//other variables
token_uri = "https://" & tenantID & ".essentialintelligence.com/api/oauth/token";
redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html";
logout_uri = "";        //superfluous? - to remove
windowHeight = "500";   //superfluous? - to remove
windowWidth = "500";    //superfluous? - to remove

[DataSource.Kind="EAS_Connector_v0.1", Publish="EAS_Connector_v0.1.Publish"]
shared EAS_Connector_v0.1.Contents = (dataUrl as text) =>
    let
        //source = Json.Document(Web.Contents(dataUrl))
        source = StartLogin(dataUrl,0,1)
    in
        source;

        

// Data Source Kind description
EAS_Connector_v0.1 = [
   TestConnection = (dataSourcePath) => { "EAS_Connector_v0.1.Contents", dataSourcePath },
   // Declares the supported type(s) of authentication.
   // In this case, Implicit = Anonymous web access
   Authentication = [
     /* OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin,
            Refresh = Refresh,
            Logout = Logout
           ]*/
                 // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        // Implicit = []
        Anonymous = []
       ],
    // Assigns a label to the data source credential.
    // This will be displayed in the "Manage Data Sources" dialog.
    Label = Extension.LoadString("DataSourceLabel")
];

StartLogin = (resourceUrl, state, display) =>
/*        let
            AuthorizeUrl = token_uri,
                headers = [
                    #"Content-Type" = "application/json",
                    #"x-api-key" = api_key
                ],
        request = Web.Contents(AuthorizeUrl, [ Headers = headers, ManualCredentials = true ])
        in
            [
                LoginUri = AuthorizeUrl,
                CallbackUri = redirect_uri,
                WindowHeight = windowHeight,
                WindowWidth = windowWidth,
                Context = null
        ];*/
let
    //apiKey = Extension.CurrentCredential()[Key],
     headers = [
                    #"Content-Type" = "application/json",
                    #"x-api-key" = api_key
                ],
    body = "{""grantType"": ""password"", ""username"":""" & vusername & """, ""password"":""" & vpassword & """}",

    request = Web.Contents(token_uri,  [ Headers = headers, Content=Text.ToBinary(body), ManualCredentials = true ]),
    TokensJSON = Json.Document(request),
    bearerToken = TokensJSON[bearerToken],
    refreshToken = TokensJSON[refreshToken],
    tokenExpiry = TokensJSON[expiresInMinutes],
        queryHeaders = [
                    #"Content-Type" = "application/json",
                    #"x-api-key" = api_key,
                    #"Authorization" = "Bearer " & bearerToken
                ],
    getDataQuery = Web.Contents(resourceUrl,  [ Headers = queryHeaders ]),
    dataQueryJSON = Json.Document(getDataQuery)          
in
    dataQueryJSON;

FinishLogin = (context, callbackUri, state) =>
    let
        Parts = Uri.Parts(callbackUri)[Query]
    in
       TokenMethod(Parts[code]);

// Called when the access_token has expired, and a refresh_token is available.
// 
Refresh = (resourceUrl, refresh_token) => TokenMethod("refresh_token", refresh_token);

Logout = (token) => logout_uri;

TokenMethod = (grantType, code) =>
    let
        query = [
            grant_type = grantType,
 //         client_id = client_id,
 //         client_secret = client_secret,
            redirect_uri = redirect_uri
        ],

        queryWithCode = if (grantType = "refresh_token") then [ refresh_token = code ] else [code = code],

        response = Web.Contents(token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(query & queryWithCode)),
            Headers=[
                #"Content-type" = "application/x-www-form-urlencoded",
                #"x-api-key" = api_key
                ],
            ManualStatusHandling = {400} 
            ]),
        body = Json.Document(response),
        result = if  (Record.HasFields(body, {"error", "error_description"})) then  
                    error Error.Record(body[error], body[error_description], body)
                 else
                    body
    in
        result;



// Data Source UI publishing description
EAS_Connector_v0.1.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = EAS_Connector_v0.1.Icons,
    SourceTypeImage = EAS_Connector_v0.1.Icons
];

EAS_Connector_v0.1.Icons = [
    Icon16 = { Extension.Contents("EAS_Connector_v0.116.png"), Extension.Contents("EAS_Connector_v0.120.png"), Extension.Contents("EAS_Connector_v0.124.png"), Extension.Contents("EAS_Connector_v0.132.png") },
    Icon32 = { Extension.Contents("EAS_Connector_v0.132.png"), Extension.Contents("EAS_Connector_v0.140.png"), Extension.Contents("EAS_Connector_v0.148.png"), Extension.Contents("EAS_Connector_v0.164.png") }
];

