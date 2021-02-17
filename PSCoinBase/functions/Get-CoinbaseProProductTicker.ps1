function Get-CoinbaseProProductTicker
{
    [CmdletBinding()]
    param(
        [string]$ProductID
    )

    $IRMParams = @{
        URI         = "$Script:CoinBaseProAPIURI/products/$ProductID/ticker"
        method      = 'GET'
        ErrorAction = 'Stop'
    }

    Invoke-RestMethod @IRMParams

}