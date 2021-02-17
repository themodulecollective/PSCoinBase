function Get-CoinbaseProProductOrderBook
{
    [CmdletBinding()]
    param(
        [string]$ProductID
        ,
        [Parameter()]
        [ValidateRange(1, 3)]
        [int]$Level #Level 1 is default
    )

    $IRMParams = @{
        URI         = "$Script:CoinBaseProAPIURI/products/$ProductID/book"
        method      = 'GET'
        ErrorAction = 'Stop'
    }

    if ($Level -ge 2)
    {
        $IRMParams.URI = $IRMParams.URI + "?level=$Level"
    }

    Invoke-RestMethod @IRMParams

}