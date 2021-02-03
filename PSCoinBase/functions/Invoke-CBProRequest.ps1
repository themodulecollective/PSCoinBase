function Invoke-CBProRequest
{
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [pscustomobject]$Request
        ,
        [bigint]$ResultSize = 100
    )

    $PageSize = 100
    Test-CBAPIKeysProvided -Pro
    if ($ResultSize -lt $PageSize)
    {
        switch ($Request.url -like '*`?*')
        {
            $true
            {
                $Request.url = $Request.url + "&limit=$ResultSize"
                #$Request.url = $Request.url + "&limit=$PageSize"
            }
            $false
            {
                $Request.url = $Request.url + "?limit=$ResultSize"
                #$Request.url = $Request.url + "?limit=$PageSize"
            }
        }
    }
    $TotalResultCount = 0
    $SpinAgain = $true
    do
    {
        $timeStamp = Get-CBAccessTimeStamp #-Pro -UseAPITimeService
        $preHash = $timeStamp + $Request.method + $Request.url
        if ($null -ne $Request.body) { $preHash = $preHash + $Request.body }
        $CBAccessSign = Get-CBAccessSign -message $preHash -Pro
        $URI = $script:CoinBaseProAPIURI + $request.url
        $Headers = @{
            "CB-ACCESS-KEY"        = $Script:CoinBaseProAPIPublicKey
            "CB-ACCESS-SIGN"       = $CBAccessSign
            "CB-ACCESS-TIMESTAMP"  = $timestamp
            "CB-ACCESS-PASSPHRASE" = $($script:CoinBaseProAPIPassPhrase | ConvertFrom-SecureString -AsPlainText)
            "Content-Type"         = 'application/json'
            #"accept"               = 'application/json'
        }
        $IRMParams = @{
            Method                  = $Request.Method
            Uri                     = $URI
            Headers                 = $Headers
            ErrorAction             = 'Stop'
            ResponseHeadersVariable = 'ResponseHeaders'
        }
        if ($Request.Method -ne 'GET')
        {
            $IRMParams.Body = $Request.body
        }
        try
        {
            $Response = Invoke-RestMethod @IRMParams
            $TotalResultCount += $Response.count
            switch ($Response.count)
            {
                {$_ -eq $PageSize -and $TotalResultCount -lt $ResultSize}
                {
                    $SpinAgain = $true
                    $after = $ResponseHeaders.'Cb-after'
                    $Response
                }
                {$_ -lt $PageSize}
                {
                    $SpinAgain = $false
                    $Response
                }
                {$TotalResultCount -ge $ResultSize}
                {
                    $DiscardResults = $TotalResultCount - $ResultSize
                    $SpinAgain = $false
                    $Response[0..$($Response.count - $DiscardResults)]
                }
                Default
                {
                    $SpinAgain = $false
                }
            }
        }
        catch
        {
            $FullError = $_
            $StatusCode = $FullError.Exception.Message
            $ErrorCode = $Statuscode | Select-String -Pattern '\d{3,3}'
            $Errors = $ErrorCode.Matches.Value
            switch ($Errors)
            {
                '400' { Write-Error "Bad Request. Invalid request format" }
                '401' { Write-Error "Unauthorized. Invalid API Key" }
                '403' { Write-Error "Forbidden. You do not have access to the requested resource" }
                '404' { Write-Error "Not Found" }
                '500' { Write-Error "Internal Server Error" }
            }
            $FullError
        }
        if ($SpinAgain) #temp value for testing, default 100
        {
            switch ($Request.url -like '*`?*')
            {
                $false
                {
                    $Request.url = $Request.url + "?after=$after"
                }
                $true
                {
                    switch ($Request.url -like '*after=*')
                    {
                        $true
                        {
                            $Request.url = $Request.url -replace 'after=(.*)', "after=$after"
                        }
                        $false
                        {
                            $Request.url = $Request.url + "&after=$after"
                        }
                    }
                }
            }
        }
    }
    until ($false -eq $SpinAgain)

}