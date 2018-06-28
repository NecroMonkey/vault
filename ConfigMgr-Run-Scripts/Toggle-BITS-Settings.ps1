<#
.SYNOPSIS
Based on parameters, turn BITS on or off

.DESCRIPTION
Script will enable and disable BITS as well as set on and off schedule BITS rate and the time frame that max rate is set for.  
It tries to stop the BITS service before altering the registry and then attempts to restart the servive.  
Only the enableBITS parameter is required and the script will skip optional parameters if not set. 

.PARAMETER enableBITS
Toggle if BITS is enabled or disbaled.  1 is enable and 0 is disable

.PARAMETER MaxFrom
Sets throttling windows start time

.PARAMETER MaxTo
Sets throttling windows end time

.PARAMETER MaxOnSchedule
Sets max transfer rate during throttling window in Kbps (9999 Kbps max)

.PARAMETER MaxOffSchedule
Sets max transfer rate outside throttling window in Kbps (9999 Kbps max)

.INPUTS

.OUTPUTS

.NOTES
FileName: Toggle-BITS-Settings.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180621
Modified: 
Version: 1.0.0

.EXAMPLE
Toggle-BITS-Settings.ps1 -enableBITS 1 -MaxFrom 12 -MaxTo 18 -MaxOnSchedule 100 -MaxOffSchedule 9999 
Toggle-BITS-Settings.ps1 -enableBITS 0

#>

#-----Parameters-----

Param(
    [Parameter(Mandatory=$True)]
    [string]$enableBITS,

    [Parameter(Mandatory=$false)]
    [string]$MaxFrom,

    [Parameter(Mandatory=$false)]
    [string]$MaxTo,

    [Parameter(Mandatory=$false)]
    [string]$MaxOnSchedule,

    [Parameter(Mandatory=$false)]
    [string]$MaxOffSchedule
)


#-----Initializations and Module Imports-----

#-----Variables-----

$name = 'BITS'

#-----Functions-----

#-----Logging-----

#-----Execution-----

Stop-Service $name

Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\BITS' -name EnableBITSMaxBandwidth -value $enableBITS -Force

If ($MaxFrom -ne $Null) 
{
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\BITS' -name MaxBandwidthValidFrom -value $MaxFrom -Force
}

If ($MaxTo -ne $Null) 
{
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\BITS' -name MaxBandwidthValidTo -value $MaxTo -Force
}

If ($MaxOnSchedule -ne $Null) 
{
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\BITS' -name MaxTransferRateOffSchedule -value $MaxOnSchedule -Force
}

If ($MaxOffSchedule -ne $Null) 
{
    Set-ItemProperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\BITS' -name MaxTransferRateOnSchedule -value $MaxOffSchedule -Force
}

Start-Service $name