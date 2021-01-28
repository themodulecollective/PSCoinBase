#https://api.coinbase.com/v2/currencies
function Get-CoinbaseCurrency
{
    [CmdletBinding()]
    param(
    )

    $IRMParams = @{
        uri         = "$script:CoinBaseAPIURI/v2/currencies"
        method      = 'GET'
        ErrorAction = 'Stop'
    }

    (Invoke-RestMethod @IRMParams).data

}