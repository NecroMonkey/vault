<#
.SYNOPSIS
The script checks the registry and WMI to determine if a system has a pending reboot.

.DESCRIPTION
Checks HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending, HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired, and HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager as well as \\.\root\ccm\clientsdk:CCM_ClientUtilities for indication of pending reboot.

.PARAMETER 

.INPUTS

.OUTPUTS

.NOTES
FileName: check-pending-reboot.ps1
Author: Michael Schultz
Contact: mschultz@necro-monkey.com
Created: 20180618
Modified: 
Version: 1.0.0

.EXAMPLE
check-pending-reboot.ps1

#>

#-----Parameters-----

#-----Initializations and Module Imports-----

#-----Variables-----

$msg = "No reboot required"

#-----Functions-----

#-----Logging-----

#-----Execution-----

if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { $msg = "Component Based Servicing" }
if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { $msg = "Windows Update" }
if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { $msg = "File Rename" }
 try { 
   $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
   $status = $util.DetermineIfRebootPending()
   if(($status -ne $null) -and $status.RebootPending){
     $msg = "SCCM Related"
   }
 }catch{}
 
 $msg