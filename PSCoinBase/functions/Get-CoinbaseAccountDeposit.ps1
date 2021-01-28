function Get-CoinbaseAccountDeposit
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
            ParameterSetName = 'Deposit'
        )]
        [ValidateScript( { $null -ne $($_.resource_path) })]
        [psobject[]]$Deposit
    )
    switch ($PSCmdlet.ParameterSetName)
    {
        'Account'
        {
            foreach ($a in $AccountID)
            {

                $request = [pscustomobject]@{
                    url    = "/v2/accounts/$a/deposits"
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
        'Deposit'
        {
            foreach ($d in $Deposit)
            {

                $request = [pscustomobject]@{
                    url    = $d.resource_path
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
    }

}