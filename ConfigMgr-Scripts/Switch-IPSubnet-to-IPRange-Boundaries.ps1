<#
.SYNOPSIS
The script takes an input CSV file of IPSUbnet boundaries and loops through it to create new IPRange boundaries

.SYNTAX
Switch-IPSubnet-to-IPRange-Boundaries.ps1 -inputfile file.csv -sc sitecode: <-del y>

.DESCRIPTION
The script takes an input CSV file and loops through it to create new IP range based ConfigMgr boundaries off IP subnt boundaries in the file, add it to desired boundary groups, and delete the old IPSubnet boundary.

.PARAMETER DisplayName
Name to be given to the new boundary created

.PARAMETER id
Boundary ID of the IPSubnet boundary being replaced by the new IPRange boundary

.PARAMETER range
IP Range to be used in creating the IPRange boundary.  x.x.x.x-x.x.x.x format

.PARAMETER bgid
Boundary Group ID that the new boundary will be added 

.PARAMETER del
Optional parameter to automatically remove the old IPSubnet boundary.  Suggest not using and verify new boundarie and manually delete old.  Only accepted pararmeter is y

.PARAMETER sc
ConfigMgr site code.  FOrmat is site code followed by :

.PARAMETER InputFile
Path and name of input CSV file

.INPUTS
CSV file with the following column header names: displayname, id, range, and bgid.  This is the input for the matching parameters. Each boundary group add does require a separate line 

.NOTES
FileName: Switch-IPSubnet-to-IPRange-Boundaries.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180825
Modified: 
Version: 1.0.0

.EXAMPLE
.\recreateranges.ps1 -InputFile .\InputFile.csv -del y  -sc sms:

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

#-----Variables-----

$List = Import-Csv -Path $InputFile

#-----Execution-----

#Change to ConfigMgr PSDrive
Set-Location $sc

#Create IPRange boundaries
Foreach ($item in $List)
{
    New-CMBoundary -DisplayName $item.DisplayName -BoundaryType IPRange -Value $item.range
}

#Add new boundary to boundary groups
Foreach ($item in $List)
{
    Add-CMBoundaryToGroup -BoundaryGroupID $item.bgid -BoundaryName $item.Displayname
}

#Delete old IPSubnet boundary if desired
if ($del -eq 'y')
{
    Foreach ($item in $List)
    {
        Remove-CMBoundary -Id $item.id -Force
    }
}
