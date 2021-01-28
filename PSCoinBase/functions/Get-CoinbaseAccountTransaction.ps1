function Get-CoinbaseAccountTransaction
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
            ParameterSetName = 'Transaction'
        )]
        [ValidateScript( { $null -ne $($_.resource_path) })]
        [psobject[]]$Transaction
    )
    switch ($PSCmdlet.ParameterSetName)
    {
        'Account'
        {
            foreach ($a in $AccountID)
            {

                $request = [pscustomobject]@{
                    url    = "/v2/accounts/$a/transactions"
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
        'Transaction'
        {
            foreach ($t in $Transaction)
            {

                $request = [pscustomobject]@{
                    url    = $t.resource_path
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
    }

}