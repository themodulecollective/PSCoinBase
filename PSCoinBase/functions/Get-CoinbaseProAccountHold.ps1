function Get-CoinbaseProAccountHold
{
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [Alias('ID')]
        [string]$AccountID
        ,
        [parameter()]
        [bigint]$ResultSize = 1000
    )

    $request = [pscustomobject]@{
        url    = "/accounts/$AccountID/holds"
        method = 'GET'
    }

    Invoke-CBProRequest -Request $request -ResultSize $ResultSize -Paginated

}