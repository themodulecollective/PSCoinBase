function Get-CoinbaseAccountBuy
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
            ParameterSetName = 'Buy'
        )]
        [ValidateScript( { $null -ne $($_.resource_path) })]
        [psobject[]]$Buy
    )
    switch ($PSCmdlet.ParameterSetName)
    {
        'Account'
        {
            foreach ($a in $AccountID)
            {

                $request = [pscustomobject]@{
                    url    = "/v2/accounts/$a/buys"
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
        'Buy'
        {
            foreach ($b in $Buy)
            {

                $request = [pscustomobject]@{
                    url    = $b.resource_path
                    method = 'GET'
                }

                Invoke-CBRequest -Request $request
            }
        }
    }

}