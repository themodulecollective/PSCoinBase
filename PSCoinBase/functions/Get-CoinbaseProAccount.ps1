function Get-CoinbaseProAccount
{
    [CmdletBinding()]
    param(
        [parameter()]
        [Alias('ID')]
        [string]$AccountID
    )

    $request = [pscustomobject]@{
        url    = '/accounts'
        method = 'GET'
    }
    if (-not [string]::IsNullOrWhiteSpace($AccountID))
    {
        $request.url = $request.url + '/' + $AccountID
    }
    Invoke-CBProRequest -Request $request

}