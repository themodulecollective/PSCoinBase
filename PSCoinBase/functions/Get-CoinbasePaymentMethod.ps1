function Get-CoinbasePaymentMethod
{
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param(
        [parameter(
            Mandatory,
            ParameterSetName = 'PaymentMethodID'
        )]
        [string[]]$PaymentMethodID
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'All'
        {
            $request = [pscustomobject]@{
                url    = '/v2/payment-methods'
                method = 'GET'
            }
            Invoke-CBRequest -Request $request
        }
        'PaymentMethodID'
        {

            foreach ($pm in $PaymentMethodID)
            {
                $request = [pscustomobject]@{
                    url    = '/v2/payment-methods'
                    method = 'GET'
                }
                $request.url = $request.url + '/' + $pm
                Invoke-CBRequest -Request $request
            }
        }
    }

}