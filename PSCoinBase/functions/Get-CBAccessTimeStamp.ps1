function Get-CBAccessTimeStamp
{
    param(
        [switch]$UseAPITimeService
    )

    switch ($UseAPITimeService)
    {
        $true
        {
            $(Invoke-RestMethod -Uri $script:CoinbaseAPITimeServiceURI).data.epoch
        }
        default
        {
            $EpochStart = Get-Date -Date "01/01/1970"
            $Timestamp = (New-TimeSpan -Start $EpochStart -End (Get-Date).ToUniversalTime()).TotalSeconds
            $Timestamp = ([math]::Round($Timestamp, 0)).ToString()
            $Timestamp
        }
    }



}
