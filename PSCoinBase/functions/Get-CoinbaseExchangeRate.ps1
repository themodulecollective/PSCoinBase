function Get-CoinbaseExchangeRate
{
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        #[validateset('USD', 'EUR', 'CAD', 'ETH', 'GRT')]
        [string]$BaseCurrency
    )


    $IRMParams = @{
        uri         = "$script:CoinBaseAPIURI/v2/exchange-rates?currency=$BaseCurrency"
        method      = 'GET'
        ErrorAction = 'Stop'
    }

    (Invoke-RestMethod @IRMParams).data.rates.psobject.Properties |
    Select-Object -Property @{n = 'BaseCurrency'; e = { $BaseCurrency } }, @{n = 'TargetCurrency'; e = { $_.Name } }, @{n = 'Rate'; e = { $_.Value } }
}