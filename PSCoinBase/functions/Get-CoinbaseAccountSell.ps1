function Get-CoinbaseAccountSell
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
            ParameterSetName = 'Sell'
        )]
        [ValidateScript( { $null -ne $($_.resource_path) })]
        [psobject[]]$Sell
    )
    switch ($PSCmdlet.ParameterSetName)
    {
        'Account'
        {
            foreach ($a in $AccountID)
            {

                $request = [pscustomobject]@{
                    url    = "/v2/accounts/$a/sells"
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
        'Sell'
        {
            foreach ($s in $Sell)
            {

                $request = [pscustomobject]@{
                    url    = $s.resource_path
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
    }

}