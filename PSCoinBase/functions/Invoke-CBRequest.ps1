function Invoke-CBRequest
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
    )

    Test-CBAPIKeysProvided

    do
    {
        $timeStamp = Get-CBAccessTimeStamp
        $preHash = $timeStamp + $Request.method + $Request.url
        if ($null -ne $Request.body) { $preHash = $preHash + $Request.body }
        $CBAccessSign = Get-CBAccessSign -message $preHash
        $URI = $script:CoinBaseAPIURI + $request.url
        $Headers = @{
            "CB-ACCESS-KEY"       = $Script:PublicKey
            "CB-ACCESS-SIGN"      = $CBAccessSign
            "CB-ACCESS-TIMESTAMP" = $timestamp
            "CB-Version"          = $script:CoinBaseAPIVersion
            "Content-Type"        = 'application/json'
            "accept"              = 'application/json'
        }
        $IRMParams = @{
            Method      = $Request.Method
            Uri         = $URI
            Headers     = $Headers
            ErrorAction = 'Stop'

        }

        if ($Request.Method -ne 'GET')
        {
            $IRMParams.Body = $Request.body
        }
        try
        {
            $Response = Invoke-RestMethod @IRMParams
            $Response.data
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
        }
        if (-not [string]::IsNullOrWhiteSpace($Response.pagination.next_uri))
        {
            $request.url = $Response.pagination.next_uri
        }
    }
    until ([string]::IsNullOrWhiteSpace($Response.pagination.next_uri))

}