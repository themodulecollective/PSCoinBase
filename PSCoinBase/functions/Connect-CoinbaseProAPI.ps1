function Connect-CoinbaseProAPI
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
            Position = 1
        )]
        [securestring]$PrivateKey
        ,
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 2
        )]
        [securestring]$PassPhrase
    )
    $Script:CoinBaseProAPIPublicKey = $PublicKey
    $Script:CoinBaseProAPIPrivateKey = $PrivateKey
    $Script:CoinBaseProAPIPassPhrase = $PassPhrase
}