function Get-CoinbaseProProductTicker
{
    [CmdletBinding()]
    param(
        [string]$ProductID
    )

    $request = [pscustomobject]@{
        url    = "/products/$ProductID/ticker"
        method = 'GET'
    }

    Invoke-CBProRequest -Request $request -ResultSize 1

}