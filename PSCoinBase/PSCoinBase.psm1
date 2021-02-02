#Requires -Version 5.1

$ModuleFolder = Split-Path $PSCommandPath -Parent

$Scripts = Join-Path -Path $ModuleFolder -ChildPath 'scripts'
$Functions = Join-Path -Path $ModuleFolder -ChildPath 'functions'

#Write-Information -MessageData "Scripts Path  = $Scripts" -InformationAction Continue
#Write-Information -MessageData "Functions Path  = $Functions" -InformationAction Continue

$Script:ModuleFiles = @(
  $(Join-Path -Path $Scripts -ChildPath 'Initialize.ps1')
  # Load Functions
  $(Join-Path -Path $functions -ChildPath 'Connect-CoinbaseAPI.ps1')
  $(Join-Path -Path $functions -ChildPath 'Connect-CoinbaseProAPI.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CBAccessSign.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CBAccessTimeStamp.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAccount.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseProAccount.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAccountBuy.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAccountDeposit.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAccountSell.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAccountTransaction.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAccountWithdrawal.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAddress.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseAddressTransaction.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseBuy.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseCurrency.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseCurrentUserAuth.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseExchangeRate.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbasePaymentMethod.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbasePrice.ps1')
  $(Join-Path -Path $functions -ChildPath 'Get-CoinbaseUser.ps1')
  $(Join-Path -Path $functions -ChildPath 'Invoke-CBRequest.ps1')
  $(Join-Path -Path $functions -ChildPath 'Invoke-CBProRequest.ps1')
  $(Join-Path -Path $functions -ChildPath 'Test-CBAPIKeysProvided.ps1')
  # Finalize / Run any Module Functions defined above
  $(Join-Path -Path $Scripts -ChildPath 'RunFunctions.ps1')
)
foreach ($f in $ModuleFiles)
{
  . $f
}