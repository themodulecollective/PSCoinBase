function Connect-CoinbaseAPI
{
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [string]$PublicKey
        ,
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [securestring]$PrivateKey
    )
    $Script:CoinBaseAPIPublicKey = $PublicKey
    $Script:CoinBaseAPIPrivateKey = $PrivateKey
}