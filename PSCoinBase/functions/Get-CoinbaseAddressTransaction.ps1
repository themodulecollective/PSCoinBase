function Get-CoinbaseAddressTransaction
{
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory,
            ValueFromPipeline,
            ParameterSetName = 'Address'
        )]
        [ValidateScript( { $null -ne $($_.resource_path) })]
        [psobject[]]$Address,
        [parameter(
            Mandatory,
            ValueFromPipeline,
            ParameterSetName = 'Account'
        )]
        [string[]]$AccountID
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'Address'
        {
            foreach ($a in $Address)
            {
                $request = [pscustomobject]@{
                    url    = $a.resource_path + '/transactions'
                    method = 'GET'
                }
                Invoke-CBRequest -Request $request
            }
        }
        'Account'
        {
            $Address = @(
                foreach ($a in $AccountID)
                {
                    $request = [pscustomobject]@{
                        url    = "/v2/accounts/$a/addresses"
                        method = 'GET'
                    }
                    Invoke-CBRequest -Request $request
                }
            )
            foreach ($a in $Address)
            {
                $request = [pscustomobject]@{
                    url    = $a.resource_path + '/transactions'
                    method = 'GET'
                }
                Invoke-CBRequest -Request $request
            }
        }
    }
}