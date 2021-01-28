#Requires -Version 5.1
###############################################################################################
# Module Variables
###############################################################################################
$ModuleVariables = @{
  'PSCoinBaseConfiguration'   = $null
  'CoinbaseAPITimeServiceURI' = 'https://api.coinbase.com/v2/time'
  'CoinBaseAPIURI'            = 'https://api.coinbase.com'
  'CoinBaseAPIVersion'        = '2019-11-15'
}

$ModuleVariables.getenumerator().ForEach( { Set-Variable -Scope Script -Name $_.name -Value $_.value })
#enum #name { #value; #value }

###############################################################################################
# Module Removal
###############################################################################################
#Clean up objects that will exist in the Global Scope due to no fault of our own . . . like PSSessions

$OnRemoveScript = {
  # perform cleanup
  Write-Verbose -Message 'Removing Module Items from Global Scope'
}

$ExecutionContext.SessionState.Module.OnRemove += $OnRemoveScript
