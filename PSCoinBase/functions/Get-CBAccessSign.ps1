function Get-CBAccessSign {
    Param(
        [Parameter()] $Message
    )
    $pk = $script:PrivateKey | ConvertFrom-SecureString -AsPlainText
    $hmacsha = [system.security.Cryptography.HMACSHA256]::new()
    $hmacsha.key = [Text.Encoding]::utf8.GetBytes($pk)
    $pk = $null
    $CompSha = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($message))
    $signature = ([System.BitConverter]::ToString($CompSha) -replace "-").ToLower()
    $signature
}