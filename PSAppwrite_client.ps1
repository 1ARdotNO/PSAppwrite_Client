

function Invoke-PSACREST {
    <#
    .SYNOPSIS
    blabnla
    .DESCRIPTION
    Invokethe API
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#get
    #>
    param(
        $URL = $ENV:APPWRITEURL,
        $PROJECT = $ENV:APPWRITEPROJECT,
        #$APPWRITESESSION = $GLOBAL:APPWRITESESSION,
        [Parameter(mandatory = $true)]$METHOD,
        $PATH,
        $BODY,
        [switch]$CREATESESSION
    )
    #Define SPLATT's
    if ($CREATESESSION) { $SESSIONSPLATT = @{sessionvariable = "global:APPWRITESESSION" } }else { $SESSIONSPLATT = @{ websession= $global:APPWRITESESSION } }
    $URISPLATT = @{URI = "$URL$PATH" }
    $HTTPMETHOPSPLATT = @{method = $METHOD }
    if ($BODY) { $BODDYSPLATT = @{body = $BODY } }else{$BODDYSPLATT = @{body = ""}}
    #Set headers
    $HEADERS = @{
        "X-Appwrite-Project" = $PROJECT
    }
    Invoke-restmethod @SESSIONSPLATT @URISPLATT @HTTPMETHOPSPLATT @BODDYSPLATT -Headers $HEADERS -ContentType "application/json" -SkipHttpErrorCheck
    
    #SET URL AND PROJECT
    $GLOBAL:APPWRITEURL=$URL
    $GLOBAL:APPWRITEPROJECT=$PROJECT
    #if ($CREATESESSION) { $GLOBAL:APPWRITESESSION = $APPWRITESESSION }
}

function Get-PSACAccount {
    <#
    .SYNOPSIS
    GET /account
    .DESCRIPTION
    Get the currently logged in user.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#get
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT
    )
    Invoke-PSACREST -PATH /account -METHOD GET -PROJECT $PROJECT -URL $URL
}
function New-PSACAccount {
    <#
    .SYNOPSIS
    POST /account
    .DESCRIPTION
    Use this endpoint to allow a new user to register a new account in your project. After the user registration completes successfully, you can use the /account/verfication route to start verifying the user email address. To allow the new user to login to their new account, you need to create a new account session.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#create
    #>
    param(
        [Parameter(mandatory = $true)]$email,
        [Parameter(mandatory = $true)]$password,
        [Parameter(mandatory = $true)]$URL,
        [Parameter(mandatory = $true)]$PROJECT,
        $name
    )
    $BODY = @{
        email    = $email
        password = $password
        userId = (new-guid).guid.replace("-","")
        name = $name
    } | ConvertTo-Json
    Invoke-PSACREST -PATH /account -METHOD POST -PROJECT $PROJECT -URL $URL -BODY $BODY -CREATESESSION
}
function Update-PSACEmail {
    <#
    .SYNOPSIS
    PATCH /account/email
    .DESCRIPTION
    Update currently logged in user account email address. After changing user address, the user confirmation status will get reset. A new confirmation email is not sent automatically however you can use the send confirmation email endpoint again to send the confirmation email. For security measures, user password is required to complete this request. This endpoint can also be used to convert an anonymous account to a normal one, by passing an email address and a new password.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updateEmail
    #>
}
function Get-PSACIdentity {
    <#
    .SYNOPSIS
    GET /account/identities
    .DESCRIPTION
    Get the list of identities for the currently logged in user.
    .LINK
    List Identities
    #>
    "NOT IMPLEMENTED"
}
function Remove-PSACIdentity {
    <#
    .SYNOPSIS
    DELETE /account/identities/{identityId}
    .DESCRIPTION
    Delete an identity by its unique ID.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#deleteIdentity
    #>
    "NOT IMPLEMENTED"
}
function New-PSACJWT {
    <#
    .SYNOPSIS
    POST /account/jwt
    .DESCRIPTION
    Use this endpoint to create a JSON Web Token. You can use the resulting JWT to authenticate on behalf of the current user when working with the Appwrite server-side API and SDKs. The JWT secret is valid for 15 minutes from its creation and will be invalid if the user will logout in that time frame.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createJWT
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT
    )
    Invoke-PSACREST -PATH /account/jwt -METHOD POST -PROJECT $PROJECT -URL $URL
}
function Get-PSACLogs {
    <#
    .SYNOPSIS
    GET /account/logs
    .DESCRIPTION
    Get the list of latest security activity logs for the currently logged in user. Each log returns user IP address, location and date and time of log.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#listLogs
    #>
    "NOT IMPLEMENTED"
}
function Set-PSACName {
    <#
    .SYNOPSIS
    PATCH /account/name
    .DESCRIPTION
    Update currently logged in user account name.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updateName
    #>
    "NOT IMPLEMENTED"
}
function Set-PSACPassword {
    <#
    .SYNOPSIS
    PATCH /account/password
    .DESCRIPTION
    Update currently logged in user password. For validation, user is required to pass in the new password, and the old password. For users created with OAuth, Team Invites and Magic URL, oldPassword is optional.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updatePassword
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        $newpassword,
        $oldpassword
    )
    $BODY=@{
        password=$newpassword
        oldPassword=$oldpassword
    } | ConvertTo-Json
    Invoke-PSACREST -PATH /account/password -METHOD PATCH -PROJECT $PROJECT -URL $URL -BODY $BODY
}
function Set-PSACPhone {
    <#
    .SYNOPSIS
    PATCH /account/phone
    .DESCRIPTION
    Update the currently logged in user's phone number. After updating the phone number, the phone verification status will be reset. A confirmation SMS is not sent automatically, however you can use the POST /account/verification/phone endpoint to send a confirmation SMS.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updatePhone
    #>
    "NOT IMPLEMENTED"
}
function Get-PSACPreferences {
    <#
    .SYNOPSIS
    GET /account/prefs
    .DESCRIPTION
    Get the preferences as a key-value object for the currently logged in user.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#getPrefs
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT
    )
    Invoke-PSACREST -PATH /account/prefs -METHOD GET -PROJECT $PROJECT -URL $URL
}
function Set-PSACPreferences {
    <#
    .SYNOPSIS
    PATCH /account/prefs
    .DESCRIPTION
    Update currently logged in user account preferences. The object you pass is stored as is, and replaces any previous value. The maximum allowed prefs size is 64kB and throws error if exceeded.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updatePrefs
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        $PREFS
    )
    $BODY=@{
        prefs=$PREFS
    } | ConvertTo-Json
    Invoke-PSACREST -PATH /account/prefs -METHOD PATCH -PROJECT $PROJECT -URL $URL -BODY $BODY
}
function New-PSACPasswordRecovery {
    <#
    .SYNOPSIS
    POST /account/recovery
    .DESCRIPTION
    Sends the user an email with a temporary secret key for password reset. When the user clicks the confirmation link he is redirected back to your app password reset URL with the secret key and email address values attached to the URL query string. Use the query string params to submit a request to the PUT /account/recovery endpoint to complete the process. The verification link sent to the user's email address is valid for 1 hour.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createRecovery
    #>
    "NOT IMPLEMENTED"
}
function New-PSACPasswordRecoveryConfirmation {
    <#
    .SYNOPSIS
    PUT /account/recovery
    .DESCRIPTION
    Use this endpoint to complete the user account password reset. Both the userId and secret arguments will be passed as query parameters to the redirect URL you have provided when sending your request to the POST /account/recovery endpoint. Please note that in order to avoid a Redirect Attack the only valid redirect URLs are the ones from domains you have set when adding your platforms in the console interface.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updateRecovery
    #>
    "NOT IMPLEMENTED"
}
function Get-PSACSessions {
    <#
    .SYNOPSIS
    GET /account/sessions
    .DESCRIPTION
    Get the list of active sessions across different devices for the currently logged in user.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#listSessions
    #>
    "NOT IMPLEMENTED"
}
function Remove-PSACSessions {
    <#
    .SYNOPSIS
    DELETE /account/sessions
    .DESCRIPTION
    Delete all sessions from the user account and remove any sessions cookies from the end client.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#deleteSessions
    #>
    "NOT IMPLEMENTED"
}
function New-PSACAnonymousSession {
    <#
    .SYNOPSIS
    POST /account/sessions/anonymous
    .DESCRIPTION
    Use this endpoint to allow a new user to register an anonymous account in your project. This route will also create a new session for the user. To allow the new user to convert an anonymous account to a normal account, you need to update its email and password or create an OAuth2 session.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createAnonymousSession
    #>
    "NOT IMPLEMENTED"
}
function New-PSACEmailSession {
    <#
    .SYNOPSIS
    POST /account/sessions/email
    .DESCRIPTION
    Allow the user to login into their account by providing a valid email and password combination. This route will create a new session for the user. A user is limited to 10 active sessions at a time by default.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createEmailSession
    #>
    param(
        [Parameter(mandatory = $true)]$email,
        [Parameter(mandatory = $true)]$password,
        #[Parameter(mandatory = $true)]$APPWRITESESSION,
        [Parameter(mandatory = $true)]$URL,
        [Parameter(mandatory = $true)]$PROJECT
    )
    $BODY = @{
        email    = $email
        password = $password
    } | ConvertTo-Json
    Invoke-PSACREST -PATH /account/sessions/email -METHOD POST -PROJECT $PROJECT -URL $URL -BODY $BODY -CREATESESSION
}
function New-PSACMagicURLSession {
    <#
    .SYNOPSIS
    POST /account/sessions/magic-url
    .DESCRIPTION
    Sends the user an email with a secret key for creating a session. If the provided user ID has not been registered, a new user will be created. When the user clicks the link in the email, the user is redirected back to the URL you provided with the secret key and userId values attached to the URL query string. Use the query string parameters to submit a request to the PUT /account/sessions/magic-url endpoint to complete the login process. The link sent to the user's email address is valid for 1 hour. If you are on a mobile device you can leave the URL parameter empty, so that the login completion will be handled by your Appwrite instance by default. A user is limited to 10 active sessions at a time by default.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createMagicURLSession
    #>
    "NOT IMPLEMENTED"
}
function New-PSACMagicURLSessionConfirmation {
    <#
    .SYNOPSIS
    PUT /account/sessions/magic-url
    .DESCRIPTION
    Use this endpoint to complete creating the session with the Magic URL. Both the userId and secret arguments will be passed as query parameters to the redirect URL you have provided when sending your request to the POST /account/sessions/magic-url endpoint. Please note that in order to avoid a Redirect Attack the only valid redirect URLs are the ones from domains you have set when adding your platforms in the console interface.Sends the user an email with a secret key for creating a session. If the provided user ID has not been registered, a new user will be created. When the user clicks the link in the email, the user is redirected back to the URL you provided with the secret key and userId values attached to the URL query string. Use the query string parameters to submit a request to the PUT /account/sessions/magic-url endpoint to complete the login process. The link sent to the user's email address is valid for 1 hour. If you are on a mobile device you can leave the URL parameter empty, so that the login completion will be handled by your Appwrite instance by default. A user is limited to 10 active sessions at a time by default.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updateMagicURLSession
    #>
    "NOT IMPLEMENTED"
}
