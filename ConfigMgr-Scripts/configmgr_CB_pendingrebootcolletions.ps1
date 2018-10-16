<#
.SYNOPSIS
The script creates collections for the various pending reboot reasons inventoried by ConfigMgr

.SYNTAX
configmgr_CB_pendingrebootcolletions.ps11 -sc sitecode:

.PARAMETER sc
ConfigMgr site code.  FOrmat is site code followed by :

.NOTES
FileName: configmgr_CB_pendingrebootcolletions.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20181016
Modified: 
Version: 1.0.0

.EXAMPLE
.\configmgr_CB_pendingrebootcolletions.ps1 -sc sms:

#>

#-----Parameters-----

param( 
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

#-----Execution-----

#Change to ConfigMgr PSDrive
Set-Location $sc

# Client State 1 - Configuration Manager
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 1 - Configuration Manager'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 1'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 2 - File Rename
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 2 - File Rename'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 2'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 3 - Configuration Manager, File Rename
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 3 - Configuration Manager, File Rename'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 3'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 4 - Windows Update
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 4 - Windows Update'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 4'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 5 - Configuration Manager, Windows Update
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 5 - Configuration Manager, Windows Update'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 5'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 6 - File Rename, Windows Update
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 6 - File Rename, Windows Update'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 6'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 7 - Configuration Manager, File Rename, Windows Update
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 7 - Configuration Manager, File Rename, Windows Update'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 7'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 8 - Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 8 - Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 8'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 9 - Configuration Manager, Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 9 - Configuration Manager, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 9'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 10 - File Rename, Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 10 - File Rename, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 10'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 11 - Configuration Manager, File Rename, Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 11 - Configuration Manager, File Rename, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 11'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 12 - Windows Update, Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 12 - Windows Update, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 12'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 13 - Configuration Manager, Windows Update, Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 13 - Configuration Manager, Windows Update, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 13'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 14 - File Rename, Windows Update, Add or Remove Feature 
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 14 - File Rename, Windows Update, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 14'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable

# Client State 15 - Configuration Manager, File Rename, Windows Update, Add or Remove Feature
    $limiter1 = 'SMS00001'
    $collectionname = 'Systems Pending Reboot with Client State 15 - Configuration Manager, File Rename, Windows Update, Add or Remove Feature'
    $rulevariable = 'select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System join sms_combineddeviceresources comb on comb.resourceid = sms_r_system.resourceid where comb.clientstate = 15'
    $recurint = 'Days'
    $recurct = '1'
    $schedule = New-CMSchedule -RecurInterval $recurint -RecurCount $recurct
    New-CMDeviceCollection -LimitingCollectionId $limiter1 -Name $collectionname -RefreshSchedule $schedule
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $collectionname  -RuleName Rule -QueryExpression $rulevariable