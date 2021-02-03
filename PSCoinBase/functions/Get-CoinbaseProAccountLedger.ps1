function Get-CoinbaseProAccountLedger
{
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$AccountID
        ,
        [parameter()]
        [bigint]$ResultSize = 1000
    )

    $request = [pscustomobject]@{
        url    = "/accounts/$AccountID/ledger"
        method = 'GET'
    }

    Invoke-CBProRequest -Request $request -ResultSize $ResultSize

}