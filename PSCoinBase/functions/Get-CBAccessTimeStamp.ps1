function Get-CBAccessTimeStamp
{
    param(
        [switch]$UseAPITimeService
        ,
        [switch]$Pro
    )

    switch ($UseAPITimeService)
    {
        $true
        {
            switch ($pro)
            {
                $true
                {
                    $(Invoke-RestMethod -Uri $script:CoinbaseProAPITimeServiceURI).data.epoch
                }
                default
                {
                    $(Invoke-RestMethod -Uri $script:CoinbaseAPITimeServiceURI).data.epoch
                }
            }

        }
        default
        {
            #$EpochStart = Get-Date -Date "01/01/1970"
            #$Timestamp = (New-TimeSpan -Start $EpochStart -End (Get-Date).ToUniversalTime()).TotalSeconds
            #$Timestamp = ([math]::Round($Timestamp, 0)).ToString()
            Get-Date -UFormat %s
        }
    }

}
