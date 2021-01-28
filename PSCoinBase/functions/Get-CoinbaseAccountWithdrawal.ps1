function Get-CoinbaseAccountWithdrawal
{
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory,
            ValueFromPipeline,
            ParameterSetName = 'Account'
        )]
        [string[]]$AccountID,

        [parameter(
            Mandatory,
            ValueFromPipeline,
            ParameterSetName = 'Withdrawal'
        )]
        [ValidateScript( { $null -ne $($_.resource_path) })]
        [psobject[]]$Withdrawal
    )
    switch ($PSCmdlet.ParameterSetName)
    {
        'Account'
        {
            foreach ($a in $AccountID)
            {

                $request = [pscustomobject]@{
                    url    = "/v2/accounts/$a/withdrawals"
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
        'Withdrawal'
        {
            foreach ($w in $Withdrawal)
            {

                $request = [pscustomobject]@{
                    url    = $w.resource_path
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
    }

}