<#
.SYNOPSIS
Sets the state of a service

.SYNTAX
set-service-start.ps1 -name <servicename> -dsrdstrt <startup> -dsrdstt <status>

.DESCRIPTION
Sets the startup type (Automatic, Manual, Disabled) and status (Running, Stopped, Paused) of a specified service

.PARAMETER name
Name of service. This is name and not displayname.
ex. dhcp (not DHCP client)
ex. BITS (not Background Intelligent Transfer Service)

.PARAMETER dsrdstrt
Desired startup type: Automatic, Manual, Disabled

.PARAMETER dsrdstt
Desired status: Running, Stopped, Paused

.INPUTS

.OUTPUTS

.NOTES
FileName: set-service-state.ps1
Author: Michael Schultz
Contact: monkey@necro-monkey.com
Created: 20190301
Modified: 
Version: 

.EXAMPLE
set-service-state.ps1 -name BITS -dsrdstrt Automatic -dsrdstt Running

#>

#-----Parameters-----

Param(
    [Parameter(Mandatory=$True)]
    [string]$name,

    [Parameter(Mandatory=$true)]
    [string]$dsrdstrt,

    [Parameter(Mandatory=$True)]
    [string]$dsrdstt
)

#-----Initializations and Module Imports-----

#-----Variables-----

$srv = get-service $name -ErrorAction SilentlyContinue

#-----Functions-----

#-----Logging-----

#-----Execution-----

if ($srv)
{
    $srvstat = $srv.status
    $srvstart = $srv.StartType

    if ($srvstart -ne "$dsrdstrt")
    {
        Set-Service -Name $name -StartupType $dsrdstrt
    }
 
    if ($srvstat -ne "$dsrdstt")
    {
        Set-Service -Name $name -Status $dsrdstt
    }

 }