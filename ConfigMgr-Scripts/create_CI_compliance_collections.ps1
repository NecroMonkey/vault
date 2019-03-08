<#
.SYNOPSIS
This script creates Compliant, Non-Compliant, and Failure collections for Copliance Settings Configuration Items

.SYNTAX
create_CI_compliance_collections.ps1 -sc <site_code> -limiter <limiting_collection> -ciname <Name_of_CI>

.DESCRIPTION
The script uses Get-CMConfigurationItem cmdlet to get a list of LocalizedDisplayNames of Compliance Setting CIs and then runs a Foreach to create three collections based using the LocalizedDisplayName.  Parameters specify the CM Site Code, LImiting Collection collection ID, and the CI Name. It does a check to see if a collection exists beofre creating which is also a self repair feature as a deleted collection will be recreated.

.PARAMETER sc
ConfigMgr site code.  Format is site code followed by :

.PARAMETER limiter
Collection ID of limiting collection

.PARAMETER ciname
Name of the CI to build collections off.  This can use * as wildcard as the command run is Get-CMConfigurationItem -fast -Name $ciname | Select-Object -ExpandProperty LocalizedDisplayName

.INPUTS

.OUTPUTS

.NOTES
FileName: create_CI_compliance_collections.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20190307
Modified: 
Version: 1

.EXAMPLE
create_CI_compliance_collections.ps1 -sc BOB -limiter SMS00001 -ciname *bob*

#>

#-----Parameters-----

Param (
    [Parameter(ParameterSetName=2,Mandatory=$true)]
    [string]$sc,
    [Parameter(ParameterSetName=2,Mandatory=$true)]
    [string]$limiter,
    [Parameter(ParameterSetName=2,Mandatory=$true)]
    [string]$ciname    

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

$recurint = 'Days'
$recurct = '1'
$schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
$cis = Get-CMConfigurationItem -fast -Name $ciname | Select-Object -ExpandProperty LocalizedDisplayName

#-----Functions-----

#-----Logging-----

#-----Execution-----

Foreach ($LocalizedDisplayName in $cis)
{

    $cildname = $LocalizedDisplayName
    $collcompliant = $cildname + ' - Compliant'
    $collnoncompliant = $cildname + ' - Non-Compliant'
    $collerror = $cildname + ' - Failure'

    $CollectionExist = Get-CMDeviceCollection -Name $collcompliant
    If(!($CollectionExist)) {
        $rulevariablecomp = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceID in (select SMS_CI_COMP.ResourceID from SMS_CI_CurrentComplianceStatus as SMS_CI_COMP inner join SMS_ConfigurationItem as SMS_CI on SMS_CI.ci_id=SMS_CI_COMP.ci_id where ((SMS_CI_COMP.DisplayName = "' + $cildname + '" and SMS_CI.islatest = 1  and SMS_CI_COMP.ComplianceState != 1) and SMS_CI_COMP.LastComplianceMessageTime >= Dateadd(dd,-7,GETDATE())))'
        New-CMDeviceCollection -LimitingCollectionId $limiter -Name $collcompliant -RefreshSchedule $schedule
        Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collcompliant  -RuleName Rule -QueryExpression $rulevariablecomp
    }

    $CollectionExist = Get-CMDeviceCollection -Name $collnoncompliant
    If(!($CollectionExist)) {
        $rulevariablenon = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceID in (select SMS_CI_COMP.ResourceID from SMS_CI_CurrentComplianceStatus as SMS_CI_COMP inner join SMS_ConfigurationItem as SMS_CI on SMS_CI.ci_id=SMS_CI_COMP.ci_id where ((SMS_CI_COMP.DisplayName = "' + $cildname + '" and SMS_CI.islatest = 1  and SMS_CI_COMP.ComplianceState != 1) and SMS_CI_COMP.LastComplianceMessageTime >= Dateadd(dd,-7,GETDATE())))'
        New-CMDeviceCollection -LimitingCollectionId $limiter -Name $collnoncompliant -RefreshSchedule $schedule
        Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collnoncompliant  -RuleName Rule -QueryExpression $rulevariablenon
    }

    $CollectionExist = Get-CMDeviceCollection -Name $collerror
    If(!($CollectionExist)) {
        $rulevariableer = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceID in (select SMS_CI_COMP.ResourceID from SMS_CI_CurrentComplianceStatus as SMS_CI_COMP inner join SMS_ConfigurationItem as SMS_CI on SMS_CI.ci_id=SMS_CI_COMP.ci_id where ((SMS_CI_COMP.DisplayName = "' + $cildname + '" and SMS_CI.islatest = 1  and SMS_CI_COMP.ComplianceState != 1) and SMS_CI_COMP.LastComplianceMessageTime >= Dateadd(dd,-7,GETDATE())))'
        New-CMDeviceCollection -LimitingCollectionId $limiter -Name $collerror -RefreshSchedule $schedule
        Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collerror  -RuleName Rule -QueryExpression $rulevariableer
    }

}