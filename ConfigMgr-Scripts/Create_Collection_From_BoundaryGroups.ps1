<#
.SYNOPSIS
This script creates collections off Boundary Groups

.SYNTAX
Create_Collection_From_BoundaryGroups.ps1 -sc <site_code>

.DESCRIPTION

.PARAMETER sc
ConfigMgr site code.  Format is site code followed by :

.INPUTS

.OUTPUTS

.NOTES
FileName: Create_Collection_From_BoundaryGroups.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20200422
Modified: 
Version: 1.0.0

.EXAMPLE
Create_Collection_From_BoundaryGroups.ps1 -sc BOB:

#>

#-----Parameters-----

Param (
    [Parameter(ParameterSetName=2,Mandatory=$true)]
    [string]$sc

)
#-----Initializations and Module Imports-----

#Get ConfigMgr Console Install Path to locate PS Module.

If (Test-Path "C:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1")
{
    Import-Module "C:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
}
elseIf (Test-Path "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1")
{
    Import-Module "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
}
elseif (test-path "d:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1")
{
    Import-Module "d:\Program Files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
}
elseIf (Test-Path "d:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1")
{
    Import-Module "d:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
}
Else {
    Write-output "Can't Find your ConfigMgr Module"
    exit
}

#Change to ConfigMgr PSDrive
Set-Location $sc

#-----Variables-----

$limiter = 'SMS00001'
$recurint = 'Days'
$recurct = '1'
$schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
$bg = Get-CMBoundaryGroup | Select-Object Name

#-----Functions-----

#-----Logging-----

#-----Execution-----

Foreach ($record in $bg)
{

    $bgname = $record.Name
    #--$bgid = $record.GroupID

    $CollectionExist = Get-CMDeviceCollection -Name $bgname
    If(!($CollectionExist)) {
        $rulevariablecomp = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceId in  (select resourceid from SMS_CollectionMemberClientBaselineStatus  where SMS_CollectionMemberClientBaselineStatus.boundarygroups like "%' + $bgname + '%")'
        New-CMDeviceCollection -LimitingCollectionId $limiter -Name $bgname -RefreshSchedule $schedule
        Add-CMDeviceCollectionQueryMembershipRule -CollectionName $bgname  -RuleName $bgname -QueryExpression $rulevariablecomp
    }

}