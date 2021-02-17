function Get-CoinbaseProProduct

{
    [CmdletBinding()]
    param(
        [string]$ProductID
    )


    $IRMParams = @{
        URI         = "$Script:CoinBaseProAPIURI/products"
        method      = 'GET'
        ErrorAction = 'Stop'
    }

    if (-not [string]::IsNullOrWhiteSpace($ProductID))
    {
        $IRMParams.URI = $IRMParams.URI + "/$ProductID"
    }

    Invoke-RestMethod @IRMParams

}