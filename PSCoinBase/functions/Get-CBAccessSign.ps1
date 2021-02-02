function Get-CBAccessSign
{
    Param(
        [Parameter()] $Message
        ,
        [switch]$Pro
    )
    switch ($Pro)
    {
        $true
        {
            $pk = $script:CoinBaseProAPIPrivateKey | ConvertFrom-SecureString -AsPlainText
            $hmacsha = [system.security.Cryptography.HMACSHA256]::new()
            $hmacsha.key = [Convert]::FromBase64String($pk)
            $pk = $null
            $CompSha = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($message))
            $signature = [Convert]::ToBase64String($CompSha)
            $signature

        }
        default
        {
            $pk = $script:CoinBaseAPIPrivateKey | ConvertFrom-SecureString -AsPlainText
            $hmacsha = [system.security.Cryptography.HMACSHA256]::new()
            $hmacsha.key = [Text.Encoding]::utf8.GetBytes($pk)
            $pk = $null
            $CompSha = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($message))
            $signature = ([System.BitConverter]::ToString($CompSha) -replace "-").ToLower()
            $signature
        }
    }

}