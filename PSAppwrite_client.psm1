

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
############################
#####################ACCOUNT
############################
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
        $URL,
        $PROJECT,
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
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        [Parameter(mandatory = $true)]$name
    )
    $BODY=@{
        name=$name
    } | ConvertTo-Json
    Invoke-PSACREST -PATH /account/name -METHOD PATCH -PROJECT $PROJECT -URL $URL -BODY $BODY
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
        [Parameter(mandatory = $true)]$newpassword,
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
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        [Parameter(mandatory = $true)]$password,
        [Parameter(mandatory = $true)]$phone
    )
    $BODY=@{
        password=$password
        phone=$phone
    } | ConvertTo-Json
    Invoke-PSACREST -PATH /account/phone -METHOD PATCH -PROJECT $PROJECT -URL $URL -BODY $BODY
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
        [Parameter(mandatory = $true)]$PREFS
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
function Get-PSACSession {
    <#
    .SYNOPSIS
    GET /account/sessions
    .DESCRIPTION
    Get the list of active sessions across different devices for the currently logged in user.
    Combines Get session and List sessions
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#listSessions
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        $Sessionid
    )
    if($Sessionid){#if sessionid specified, get that one
        Invoke-PSACREST -PATH /account/sessions/$Sessionid -METHOD GET -PROJECT $PROJECT -URL $URL
    }else{
        #If no sessionid specified, get all
        Invoke-PSACREST -PATH /account/sessions -METHOD GET -PROJECT $PROJECT -URL $URL
    }
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
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        $Sessionid
    )
    if($Sessionid){#if sessionid specified, get that one
        Invoke-PSACREST -PATH /account/sessions/$Sessionid -METHOD DELETE -PROJECT $PROJECT -URL $URL
    }else{
        #If no sessionid specified, get all
        Invoke-PSACREST -PATH /account/sessions -METHOD DELETE -PROJECT $PROJECT -URL $URL
    }
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
        $URL,
        $PROJECT
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
function New-PSACOauth2Session {
    <#
    .SYNOPSIS
    GET /account/sessions/oauth2/{provider}
    .DESCRIPTION
    Allow the user to login to their account using the OAuth2 provider of their choice. Each OAuth2 provider should be enabled from the Appwrite console first. Use the success and failure arguments to provide a redirect URL's back to your app when login is completed.
    If there is already an active session, the new session will be attached to the logged-in account. If there are no active sessions, the server will attempt to look for a user with the same email address as the email received from the OAuth2 provider and attach the new session to the existing user. If no matching user is found - the server will create a new user.
    A user is limited to 10 active sessions at a time by default.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createOAuth2Session
    #>
    "NOT IMPLEMENTED"
}
function New-PSACPhoneSession {
    <#
    .SYNOPSIS
    POST /account/sessions/phone
    .DESCRIPTION
    Sends the user an SMS with a secret key for creating a session. If the provided user ID has not be registered, a new user will be created. Use the returned user ID and secret and submit a request to the PUT /account/sessions/phone endpoint to complete the login process. The secret sent to the user's phone is valid for 15 minutes.
    A user is limited to 10 active sessions at a time by default.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createPhoneSession
    #>
    "NOT IMPLEMENTED"
}
function New-PSACPhoneSessionConfirmation {
    <#
    .SYNOPSIS
    PUT /account/sessions/phone
    .DESCRIPTION
    Use this endpoint to complete creating a session with SMS. Use the userId from the createPhoneSession endpoint and the secret received via SMS to successfully update and confirm the phone session.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updatePhoneSession
    #>
    "NOT IMPLEMENTED"
}
function New-PSACOauth2SessionRefresh {
    <#
    .SYNOPSIS
    PATCH /account/sessions/{sessionId}
    .DESCRIPTION
    Access tokens have limited lifespan and expire to mitigate security risks. If session was created using an OAuth provider, this route can be used to "refresh" the access token.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updateSession
    #>
    "NOT IMPLEMENTED"
}
function Set-PSACAccountDisabled {
    <#
    .SYNOPSIS
    PATCH /account/status
    .DESCRIPTION
    Block the currently logged in user account. Behind the scene, the user record is not deleted but permanently blocked from any access. To completely delete a user, use the Users API instead.
    .LINK
    https://appwrite.io/docs/references/cloud/client-web/account#updateStatus
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT
    )
    Invoke-PSACREST -PATH /account/status -METHOD PATCH -PROJECT $PROJECT -URL $URL
}
function New-PSACEmailVerification {
    <#
    .SYNOPSIS
    POST /account/verification
    .DESCRIPTION
    Use this endpoint to send a verification message to your user email address to confirm they are the valid owners of that address. Both the userId and secret arguments will be passed as query parameters to the URL you have provided to be attached to the verification email. The provided URL should redirect the user back to your app and allow you to complete the verification process by verifying both the userId and secret parameters. Learn more about how to complete the verification process. The verification link sent to the user's email address is valid for 7 days. Please note that in order to avoid a Redirect Attack, the only valid redirect URLs are the ones from domains you have set when adding your platforms in the console interface.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createVerification
    #>
    "NOT IMPLEMENTED"
}
function New-PSACEmailVerificationConfirmation {
    <#
    .SYNOPSIS
    PUT /account/verification
    .DESCRIPTION
    Use this endpoint to complete the user email verification process. Use both the userId and secret parameters that were attached to your app URL to verify the user email ownership. If confirmed this route will return a 200 status code.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updateVerification
    #>
    "NOT IMPLEMENTED"
}
function New-PSACPhoneVerification {
    <#
    .SYNOPSIS
    POST /account/verification/phone
    .DESCRIPTION
    Use this endpoint to send a verification SMS to the currently logged in user. This endpoint is meant for use after updating a user's phone number using the accountUpdatePhone endpoint. Learn more about how to complete the verification process. The verification code sent to the user's phone number is valid for 15 minutes.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#createPhoneVerification
    #>
    "NOT IMPLEMENTED"
}
function New-PSACPhoneVerificationConfirmation {
    <#
    .SYNOPSIS
    PUT /account/verification/phone
    .DESCRIPTION
    Use this endpoint to complete the user phone verification process. Use the userId and secret that were sent to your user's phone number to verify the user email ownership. If confirmed this route will return a 200 status code.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/account#updatePhoneVerification
    #>
    "NOT IMPLEMENTED"
}

#############################
#####################Database
#############################
function Get-PSACDocument {
    <#
    .SYNOPSIS
    GET /databases/{databaseId}/collections/{collectionId}/documents
    .DESCRIPTION
    Get a list of all the user's documents in a given collection. You can use the query params to filter your results.
    .LINK
    https://appwrite.io/docs/references/cloud/client-rest/databases#listDocuments
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        [Parameter(mandatory = $true)]$collectionid,
        [Parameter(mandatory = $true)]$databaseid,
        $documentid
    )
    if($documentid){
        #if sessionid specified, get that one
        Invoke-PSACREST -PATH /databases/$databaseid/collections/$collectionid/documents/$documentid -METHOD GET -PROJECT $PROJECT -URL $URL
    }else{
        #If no sessionid specified, get all
        Invoke-PSACREST -PATH /databases/$databaseid/collections/$collectionid/documents -METHOD GET -PROJECT $PROJECT -URL $URL

    }
}
function New-PSACDocument {
    <#
    .SYNOPSIS
    POST /databases/{databaseId}/collections/{collectionId}/documents
    .DESCRIPTION
    Create a new Document. Before using this route, you should create a new collection resource using either a server integration API or directly from your database console.
    .LINK
    https://appwrite.io/docs/references/1.5.x/client-rest/databases#createDocument
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        [Parameter(mandatory = $true)]$collectionid,
        [Parameter(mandatory = $true)]$databaseid,
        $documentid=$((new-guid).guid.replace("-","")),
        [Parameter(mandatory = $true)]$data,
        $rawpermissions,
        $readpermission,
        $updatepermission,
        $deletepermission,
        $writepermission
    )
    $body=@{
        documentId=$documentid
        data=$data
    }
    if($rawpermissions){$body | Add-Member -MemberType NoteProperty -Name permissions -Value $rawpermissions}
    #permissions
    elseif($readpermission -or $updatepermission -or $deletepermission -or $writepermission){
        $permissions=@()
        if($readpermission){$permissions+=$readpermission | ForEach-Object {'read('+'"'+$_+'"'+')'}}
        if($updatepermission){$permissions+=$updatepermission | ForEach-Object {'update('+'"'+$_+'"'+')'}}
        if($deletepermission){$permissions+=$deletepermission | ForEach-Object {'delete('+'"'+$_+'"'+')'}}
        if($writepermission){$permissions+=$writepermission | ForEach-Object {'write('+'"'+$_+'"'+')'}}
        #add to body
        $body | Add-Member -MemberType NoteProperty -Name permissions -Value $permissions
    }
    $GLOBAL:DEBUGBODY=$body
    Invoke-PSACREST -PATH /databases/$databaseid/collections/$collectionid/documents -METHOD POST -PROJECT $PROJECT -URL $URL -BODY $($body|ConvertTo-Json)
}
function Update-PSACDocument {
    <#
    .SYNOPSIS
    PATCH /databases/{databaseId}/collections/{collectionId}/documents/{documentId}
    .DESCRIPTION
    Update a document by its unique ID. Using the patch method you can pass only specific fields that will get updated.
    .LINK
    https://appwrite.io/docs/references/1.5.x/client-rest/databases#updateDocument
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        [Parameter(mandatory = $true)]$collectionid,
        [Parameter(mandatory = $true)]$databaseid,
        $documentid,
        [Parameter(mandatory = $true)]$data,
        $rawpermissions,
        $readpermission,
        $updatepermission,
        $deletepermission,
        $writepermission
    )
    $body=@{
        documentId=$documentid
        data=$data
    }
    if($rawpermissions){$body | Add-Member -MemberType NoteProperty -Name permissions -Value $rawpermissions}
    #permissions
    elseif($readpermission -or $updatepermission -or $deletepermission -or $writepermission){
        $permissions=@()
        if($readpermission){$permissions+=$readpermission | ForEach-Object {'read('+'"'+$_+'"'+')'}}
        if($updatepermission){$permissions+=$updatepermission | ForEach-Object {'update('+'"'+$_+'"'+')'}}
        if($deletepermission){$permissions+=$deletepermission | ForEach-Object {'delete('+'"'+$_+'"'+')'}}
        if($writepermission){$permissions+=$writepermission | ForEach-Object {'write('+'"'+$_+'"'+')'}}
        #add to body
        $body | Add-Member -MemberType NoteProperty -Name permissions -Value $permissions
    }
    Invoke-PSACREST -PATH /databases/$databaseid/collections/$collectionid/documents/$documentid -METHOD PATCH -PROJECT $PROJECT -URL $URL -BODY $($body|ConvertTo-Json)
}
function Remove-PSACDocument {
    <#
    .SYNOPSIS
    DELETE /databases/{databaseId}/collections/{collectionId}/documents/{documentId}
    .DESCRIPTION
    Delete a document by its unique ID.
    .LINK
    https://appwrite.io/docs/references/1.5.x/client-rest/databases#deleteDocument
    #>
    param(
        $URL=$GLOBAL:APPWRITEURL,
        $PROJECT=$GLOBAL:APPWRITEPROJECT,
        [Parameter(mandatory = $true)]$collectionid,
        [Parameter(mandatory = $true)]$databaseid,
        $documentid
    )
    write-debug "DELETING /databases/$databaseid/collections/$collectionid/documents/$documentid"
    Invoke-PSACREST -PATH "/databases/$databaseid/collections/$collectionid/documents/$documentid" -METHOD DELETE -PROJECT $PROJECT -URL $URL

}