function Get-CoinbasePrice
{
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        #[validateset('USD', 'EUR', 'CAD')]
        [string]$BaseCurrency
        ,
        [parameter(Mandatory)]
        [string]$Currency
        ,
        [parameter(Mandatory)]
        [validateset('buy', 'sell')]
        [string]$PriceType
    )


    $IRMParams = @{
        uri         = "$script:CoinBaseAPIURI/v2/prices/$Currency-$BaseCurrency/$PriceType"
        method      = 'GET'
        ErrorAction = 'Stop'
    }

    (Invoke-RestMethod @IRMParams).data
}