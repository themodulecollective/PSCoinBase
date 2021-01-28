function Get-CoinbaseAddress
{
    [CmdletBinding()]
    param(
        [string[]]$AccountID
    )

    if ([string]::IsNullOrWhiteSpace($AccountID) -and $AccountID.Count -eq 0)
    {
        $AccountID = @(Get-CoinbaseAccount | Select-Object -ExpandProperty id)
    }

    foreach ($a in $AccountID)
    {
        $request = [pscustomobject]@{
            url    = "/v2/accounts/$a/addresses"
            method = 'GET'
        }
        Invoke-CBRequest -Request $request
    }
}