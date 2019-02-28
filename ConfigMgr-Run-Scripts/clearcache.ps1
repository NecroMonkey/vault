<#
.SYNOPSIS
ConfigMgr Run Script to clear CMCache and BrnachCache

.SYNTAX
clearcache.ps1

.PARAMETER <Parameter_Name>

.INPUTS

.OUTPUTS

.NOTES
FileName: clearcache.ps1
Author: Michael Schultz
Contact: 
Created: 20190227
Modified: 
Version: 1

.EXAMPLE
clearcache.ps1

#>

#-----Parameters-----

Param (


)
#-----Initializations and Module Imports-----

#-----Variables-----

#-----Functions-----

#-----Logging-----

#-----Execution-----

#clear CM Cache
$UIResourceMgr = New-Object -ComObject UIResource.UIResourceMgr
$Cache = $UIResourceMgr.GetCacheInfo()
#Enum Cache elements, compare date, and delete them
$Cache.GetCacheElements()  | foreach {$Cache.DeleteCacheElement($_.CacheElementID)}

#clear BranchCache - Remove first '#' below to turn of BrnachCache flush.  Add back to turn back on
#<#
If([System.Environment]::OSversion.Version.Major -ge '10')
{
    Clear-BCCache -force
}
else
{
    netsh branchcache flush
}
#>