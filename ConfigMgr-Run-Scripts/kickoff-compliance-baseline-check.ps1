<#
.SYNOPSIS
ConfigMgr run script to evaluate a compliance setting baseline compliance based off the specified name of the baseline

.SYNTAX

.DESCRIPTION
Script description

.PARAMETER Name
Name of the compliance baseline

.INPUTS

.OUTPUTS

.NOTES
FileName: kickoff-compliance-baseline-check.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20190402
Modified: 
Version: 1

Original PowerShell code from Mick Pletcher (Mick's IT Blog) - https://mickitblog.blogspot.com/2019/03/initiating-sccm-compliance-check-via.html

.EXAMPLE
kickoff-compliance-baseline-check.ps1 -Name 'Baseline'

#>

#-----Parameters-----

Param(
[Parameter(Mandatory=$True)]
[string]$Name
)

#-----Initializations and Module Imports-----

#-----Variables-----

#-----Functions-----

#-----Logging-----

#-----Execution-----
 
 ([wmiclass]"root\ccm\dcm:SMS_DesiredConfiguration").TriggerEvaluation(((Get-WmiObject -Namespace root\ccm\dcm -class SMS_DesiredConfiguration | Where-Object {$_.DisplayName -eq $Name}).Name), ((Get-WmiObject -Namespace root\ccm\dcm -class SMS_DesiredConfiguration | Where-Object {$_.DisplayName -eq $Name}).Version)) 