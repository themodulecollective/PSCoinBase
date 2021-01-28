function Test-CBAPIKeysProvided
{
    if ($null -eq $Script:PublicKey -or $null -eq $script:PrivateKey)
    {
        throw('You must run "Connect-CoinbaseAPI" before running this command')
    }
}