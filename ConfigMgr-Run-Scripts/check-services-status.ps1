<#
.SYNOPSIS
Checks the status of a specified service

.DESCRIPTION

.PARAMETER servicename
Name of the service to check.  This is the service name and not the display name.  For example, Windows Event Log service would be eventlog

.INPUTS

.OUTPUTS

.NOTES
FileName: check-services-status.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180615
Modified: 
Version: 1.0.0

.EXAMPLE
check-services-status.ps1 -servicename eventlog

#>

#-----Parameters-----

Param(
[Parameter(Mandatory=$True)]
[string]$servicename
)

#-----Initializations and Module Imports-----

#-----Variables-----

$srvstat =  get-service $servicename | Select-Object -ExpandProperty status

#-----Functions-----

#-----Logging-----

#-----Execution-----

if ($srvstat -ne $null )
{$srvstat}
else {"Service Not Found"} 