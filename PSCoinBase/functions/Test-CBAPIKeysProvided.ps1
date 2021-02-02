function Test-CBAPIKeysProvided
{
    [cmdletbinding()]
    param(
        [switch]$Pro
    )
    switch ($Pro)
    {
        $true
        {
            if ($null -eq $Script:CoinBaseProAPIPublicKey -or $null -eq $script:CoinBaseProAPIPrivateKey -or $null -eq $Script:CoinBaseProAPIPassPhrase)
            {
                throw('You must run "Connect-CoinbaseProAPI" before running this command')
            }
        }
        default
        {
            if ($null -eq $Script:CoinBaseAPIPublicKey -or $null -eq $script:CoinBaseAPIPrivateKey)
            {
                throw('You must run "Connect-CoinbaseAPI" before running this command')
            }
        }
    }

}
