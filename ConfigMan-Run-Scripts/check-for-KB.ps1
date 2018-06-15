<#
.SYNOPSIS
Checks for installed KB and retuens dated installed.  This is designed to be used as a COnfigMan Run Script.

.PARAMETER KBfind
KB number to search for.  Starts with KB

.NOTES
FileName: check-for-KB.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180614
Modified: 
Version: 1.0.0

.EXAMPLE
check-for-KB.ps1 -KBfind KB2479943

#>

#-----Parameters-----

Param(
[Parameter(Mandatory=$True)]
[string]$KBfind 
)

#-----Initializations and Module Imports-----

#-----Variables-----

#-----Functions-----

#-----Logging-----

#-----Execution-----

Get-HotFix -id $KBfind -ErrorAction SilentlyContinue | Select-Object -ExpandProperty InstalledOn