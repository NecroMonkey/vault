<#
.SYNOPSIS
Checks the startup type of a specified service

.DESCRIPTION

.PARAMETER servicename
Name of the service to check.  This is the service name and not the display name.  For example, Windows Event Log service would be eventlog

.INPUTS

.OUTPUTS

.NOTES
FileName: check-services-start-type.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180615
Modified: 
Version: 1.0.0

.EXAMPLE
check-services-start-type.ps1 -servicename eventlog

#>

#-----Parameters-----

Param(
[Parameter(Mandatory=$True)]
[string]$servicename
)

#-----Initializations and Module Imports-----

#-----Variables-----

$srvstart = Get-Service -Name $servicename | Select-Object -ExpandProperty starttype

#-----Functions-----

#-----Logging-----

#-----Execution-----

if ($srvstart -ne $null )
{$srvstart}
else {"Service Not Found"}  