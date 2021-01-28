function Get-CoinbaseBuy
{
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$AccountID
    )

    $request = [pscustomobject]@{
        url    = "/v2/accounts/$AccountID/buys"
        method = 'GET'
    }
    Invoke-CBRequest -Request $request

}