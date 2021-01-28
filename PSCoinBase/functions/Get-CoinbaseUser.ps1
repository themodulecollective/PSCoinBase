function Get-CoinbaseUser
{
    [CmdletBinding()]
    param(
        [string]$UserID
    )

    $request = [pscustomobject]@{
        url    = '/v2/user'
        method = 'GET'
    }

    if (-not [string]::IsNullOrWhiteSpace($UserID))
    {
        $request.url = $request.url + 's/' + $UserID
    }

    Invoke-CBRequest -Request $request

}