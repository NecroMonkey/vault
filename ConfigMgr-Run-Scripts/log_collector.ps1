<#
.SYNOPSIS
Copy Logs from system to share

.DESCRIPTION
This script will create a directory on a share and copy CCM and other logs from the system to the share.  Deisgned to be used a a CM Run Script

.NOTES
FileName: log_collector.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20190221
Modified: 
Version: 1

.EXAMPLE
log_collector.ps1

#>

#-----Parameters-----

Param (


)
#-----Initializations and Module Imports-----

#-----Variables-----
$pcname = $env:COMPUTERNAME
$savepath = "" #specify you UNC for the share to copy logs
# remove commenting from next to lines to add date to folder name
# $datecollected = Get-Date -UFormat "%Y%m%d"
$foldername = $pcname # + "-" + $datecollected
$destinationRoot = $savepath + $foldername
$Logfile = $destinationRoot + '\log_collector.log'

$ccmlogs = 'C:\Windows\CCM\Logs'
$CCMSetuplogs = 'C:\Windows\CCMsetup\Logs'
$updatelogs = 'C:\Windows\WindowsUpdate.log'

#-----Functions-----

#-----Logging-----

#Remove log file if bigger than 1MB to prevent bloat
If (Test-Path $Logfile )
{
    if ((Get-Item $Logfile ).Length -gt 1MB) 
    {
        remove-item $Logfile 
    }
}
else
{
    new-item -Path $Logfile –itemtype file
}

#-----Execution-----

#Creates log directory
If(!(test-path $destinationRoot))
{
      New-Item -ItemType Directory -Force -Path $destinationRoot
}

#get the date/time and add some items to the log file
$mydate = Get-Date
Add-content $Logfile -value "*******************"
Add-content $Logfile -value "$mydate Starting Log Collecting"

#Grab and copy CCM logs
If(test-path $ccmlogs)
{
    $mydate = Get-Date
    Add-content $Logfile -value "$mydate Collecting CCM Logs"
    New-Item -ItemType Directory -Force -Path $destinationRoot\ccm
    Copy-Item -Path $ccmlogs\* -Recurse -Destination $destinationRoot\ccm -force -ErrorVariable ProcessError
    if ($ProcessError -ne $null)
        {
            Add-content $Logfile -value “$ProcessError”
            $ProcessError = $null
        }
}

#Grab and copy CCM Setup logs
If(test-path $CCMSetuplogs)
{
    $mydate = Get-Date
    Add-content $Logfile -value "$mydate Collecting CCM Setup Logs"
    New-Item -ItemType Directory -Force -Path $destinationRoot\ccmsetup
    Copy-Item -Path $CCMSetuplogs\* -Recurse -Destination $destinationRoot\ccmsetup -force -ErrorVariable ProcessError
    if ($ProcessError -ne $null)
        {
            Add-content $Logfile -value “$ProcessError”
            $ProcessError = $null
        }
}

#Grab and copy Winndows Update log
If([System.Environment]::OSversion.Version.Major -ge '10')
{
    $mydate = Get-Date
    Add-content $Logfile -value "$mydate Collecting Windows Update Logs"
    New-Item -ItemType Directory -Force -Path $destinationRoot\wu
    Get-WindowsUpdateLog -LogPath $destinationRoot\wu\WindowsUpdate.log -ErrorVariable ProcessError
    if ($ProcessError -ne $null)
        {
            Add-content $Logfile -value “$ProcessError”
            $ProcessError = $null
        }
}
else
{
    $mydate = Get-Date
    Add-content $Logfile -value "$mydate Collecting Windows Update Logs"
    New-Item -ItemType Directory -Force -Path $destinationRoot\wu
    Copy-Item -Path $updatelogs -Recurse -Destination $destinationRoot\wu -force -ErrorVariable ProcessError
    if ($ProcessError -ne $null)
        {
            Add-content $Logfile -value “$ProcessError”
            $ProcessError = $null
        }
}

#finalizing log
$mydate = Get-Date
Add-content $Logfile -value "$mydate Log collection completed"
