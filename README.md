# PSCoinBase

A Powershell module to access Coinbase user accounts (authenticated) and public (non authenticated) endpoints.  Currently uses only API token access.

## Latest Updates - version 0.0.2

Current Commit has support for Connecting to the Coinbase API and the Coinbase Pro API.  For Coinbase Pro, the only working command so far is Get-CoinbaseProAccount.  No pagination for CoinBasePro results has been implemented yet, but that's next on the list along with expanding the command footprint out for 'Get-' commands for Coinbase Pro.

## Attributions

Work in this module is based on samples found in the following locations:

https://stackoverflow.com/questions/28800386/coinbase-exchange-api-with-powershell
https://alittlecrumbs.com/2020/09/01/check-cryptocurrencies-price-and-amount-coinbase-wallet-with-powershell/
https://github.com/Invertee/CoinbasePro-Powershell
## Current Status

Currently this module includes commands for most (perhaps all) of the read capabilities of the Coinbase API.

## Future Plans

Develop read functions for CoinbasePro API.
Eventually may include functions for non-read operations but that is lower priority at the moment.
Considering addition of OAUTH for authentication for scenarios where this module might be integrated with a web front end using something like UniversalDashboard.
