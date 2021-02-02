function Get-CoinbaseProOrder
{
    [CmdletBinding(DefaultParameterSetName = 'Query')]
    param(
        [parameter(
            Mandatory,
            Position = 0,
            ParameterSetName = 'ID',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$ID,
        [parameter(
            Mandatory,
            Position = 0,
            ParameterSetName = 'ClientID',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]]$ClientID,
        [string]$ProductID,
        [parameter()]
        [validateset('open', 'pending', 'active', 'done', 'all')]
        [string]$Status #default returns only open orders
    )#before/afteR/limit?

    $request = [pscustomobject]@{
        url    = '/orders'
        method = 'GET'
    }

    Switch ($PSCmdlet.ParameterSetName)
    {
        'ID'
        {
            if (-not [string]::IsNullOrWhiteSpace($ID))
            {
                $request.url = $request.url + '/' + $ID
            }
        }
        'ClientID'
        {

        }
        'Query'
        {
            if (-not [string]::IsNullOrWhiteSpace($Status) -or -not [string]::IsNullOrWhiteSpace($ProductID))
            {
                $request.url = $request.url + '?'
                $queryparts = 0
                if (-not [string]::IsNullOrWhiteSpace($ProductID))
                {
                    $queryparts++
                    $request.url = $request.url + "product_id=$ProductID"
                }
                if (-not [string]::IsNullOrWhiteSpace($Status))
                {
                    $queryparts++
                    if ($queryparts -ge 2)
                    { $request.url = $request.url + '&' }
                    $request.url = $request.url + "status=$Status"

                }
            }
        }
    }


    Invoke-CBProRequest -Request $request

}