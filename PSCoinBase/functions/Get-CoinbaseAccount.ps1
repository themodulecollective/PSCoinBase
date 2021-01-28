function Get-CoinbaseAccount
{
    [CmdletBinding()]
    param(
        [string]$AccountID
    )

    $request = [pscustomobject]@{
        url    = '/v2/accounts'
        method = 'GET'
    }
    if (-not [string]::IsNullOrWhiteSpace($AccountID))
    {
        $request.url = $request.url + '/' + $AccountID
    }
    Invoke-CBRequest -Request $request

}