<#
.SYNOPSIS
Checks Add/Remove Programs (Programs and Features) for installed software. This is designed to be used as a COnfigMan Run Script.

.DESCRIPTION
This scripts grabs the software DisplayNames from HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall and HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\ and then goes through that list to see if the DisplayName set with the parameter is contained in the list.

.PARAMETER DisplayName
Name of the software to look for

.NOTES
FileName: check-ARP-for-installed-software.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180614
Modified: 
Version: 1.0.0

.EXAMPLE
check-ARP-for-installed-software.ps1 -DisplayName 'SQL Server 2012 Common Files'

#>

#-----Parameters-----

Param(
    [Parameter(Mandatory=$True)]
    [string]$DisplayName
)

#-----Initializations and Module Imports-----

#-----Variables-----

$AppFound = 'false'

#-----Functions-----

#-----Logging-----

#-----Execution-----

if ([Environment]::Is64BitProcess)
{
$x64Apps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue).displayname
$x86Apps = (Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue).displayname
}
else
{
	$x86Apps = (Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue).displayname
}

$x64Apps | Foreach-object {
	try
	{
		if ($_.Contains($DisplayName))
		{
			$AppFound = 'true'
		}
	}
	catch { }
}
$x86Apps | Foreach-obect {
	try
	{
		if ($_.Contains($DisplayName))
		{
			$AppFound = 'true'
		}
	}
	catch { }
} 

$AppFound