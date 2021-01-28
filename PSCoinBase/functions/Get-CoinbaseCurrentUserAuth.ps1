function Get-CoinbaseCurrentUserAuth
{
    [CmdletBinding()]
    param(
        [string]$UserID
    )

    $request = [pscustomobject]@{
        url    = '/v2/user/auth'
        method = 'GET'
    }

    Invoke-CBRequest -Request $request

}