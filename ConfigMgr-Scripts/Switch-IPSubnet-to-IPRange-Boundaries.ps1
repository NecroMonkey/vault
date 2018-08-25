<#
.SYNOPSIS
The script takes an input CSV file of IPSUbnet boundaries and loops through it to create a new IPRange boundaries

.SYNTAX
Script syntax

.DESCRIPTION
The script takes an input CSV file and loops through it to create a new IP range based ConfigMgr boundary, add it to 

.PARAMETER servicename
Name of the service to check.  This is the service name and not the display name.  For example, Windows Event Log service would be eventlog


.INPUTS
Input description if used

.OUTPUTS
Output description if used

.NOTES
FileName: Switch-IPSubnet-to-IPRange-Boundaries.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180825
Modified: 
Version: 1.0.0

.EXAMPLE
Example description and example

#>

#-----Parameters-----

param( 
[Parameter(ParameterSetName=1,Mandatory=$true)]
[string]$DisplayName,
[Parameter(ParameterSetName=1,Mandatory=$true)]
[string]$range,
[Parameter(ParameterSetName=1,Mandatory=$true)]
[string]$bgid,
[Parameter(ParameterSetName=1,Mandatory=$true)]
[string]$id,
[Parameter(ParameterSetName=2,Mandatory=$false)]
[string]$del,
[Parameter(ParameterSetName=2,Mandatory=$true)]
[string]$sc,
[Parameter(ParameterSetName=2,Mandatory=$true)]
[string]$InputFile
)

#-----Initializations and Module Imports-----

#Get SCCM Console Install Path to locate PS Module.

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

#-----Variables-----

$List = Import-Csv -Path $InputFile

#-----Functions-----

#-----Logging-----

#-----Execution-----

#Change to SCCM PSDrive
Set-Location $sc

Foreach ($item in $List)
{
    New-CMBoundary -DisplayName $item.DisplayName -BoundaryType IPRange -Value $item.range
}

Foreach ($item in $List)
{
    Add-CMBoundaryToGroup -BoundaryGroupID $item.bgid -BoundaryName $item.Displayname
}

if ($del -eq 'y')
{
    Foreach ($item in $List)
    {
        Remove-CMBoundary -Id $item.id -Force
    }
}
