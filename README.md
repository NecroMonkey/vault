# ReadMe

I am a ConfigMgr engineer and this is where I will be keeping my scripts, SQL queries, SSRS reports, and other things in the hopes that they will benefit the community.  If you have questions or come across an issue, please reach out to me. 

## Contents

### ./

**README.md** - This file

**Templates.code-snippets** - The code snippets I use in VSCode

### ./ConfigMgr-Run-Scripts

**check-ARP-for-installed-software.ps1** - Checks Add/Remove Programs (Programs and Features) for installed software

**check-for-KB.ps1** - Checks for installed KB and retuens dated installed

**check-pending-reboot.ps1** - Checks system for pending reboot

**check-services-start-type.ps1** - Checks the startup type of a service

**check-services-status.ps1** - Checks the status of a service

**clearcache.ps1** - ConfigMgr run script that clears the CCM cache and BranchCache cache

**log_collector.ps1** - ConfigMgr run script that grabs CCMSETUP, CCM, Windows Update, and ny addition logs you may add from a system and copied to a share

**set-service-state.ps1** - ConfigMgr run script that sets the startup type (Automatic, Manual, Disabled) and status (Running, Stopped, Paused) of a specified service

**Toggle-BITS-Settings.ps1** - Based on parameters, turn BITS on or off

### ./ConfigMgr-Scripts

**Switch-IPSubnet-to-IPRange-Boundaries.ps1** - Uses CSV file to create new IPRange boundaries based off exit IPSubnet boundaries and removes old IPSUbnet boundaries

**Switch-IPSubnet-to-IPRange-Boundaries.sql** - SQL query that can be sed with Switch-IPSubnet-to-IPRange-Boundaries.ps1 to create required input CSV file

**configmgr_CB_pendingrebootcolletions.ps1** - Script that building out ConfigMgr colections based off pending reboot reasons reported in the ConfigMgr console

### ./SSRS-Reports/ComplianceSettings-OverallStatusReports/

**Compliance Settings - Overall Status for a System.rdl** - Third level report that gives baseline and configuration item compliance for a sigle system. Baseline links back to *Compliance Settings - Overall Status of Baseline* and individual CIs link to *Compliance Settings - Overall Status of Configuration Item*

**Compliance Settings - Overall Status of Baseline.rdl** - Top level report that gives overall compliance of a ConfigMgr baseline. Individual CIs link to *Compliance Settings - Overall Status of Configuration Item*

**Compliance Settings - Overall Status of Configuration Item.rdl** - Second level report that gives compliance of configuration item within a baseline.  Baseline links back to *Compliance Settings - Overall Status of Baseline* and individual system links to *Compliance Settings - Overall Status for a System*

### ./SSRS-Reports/ContentSourceBreakdown/

**Content Source Breakdown.rdl** - Report showing a breakdown of ConfigMGr content source types (DP, Cloud DP, BranchCache, and PeerCache)

### ./SQL

**client_boundary_membership.sql** - SQL quesry that returns ConfigMgr ResourceID and associated BoundaryID into a custom table

**configmgr_systems_pending_reboot.sql** -  SQL queries that return systems pending reboot and assocaited reason and a count of pending reboot systems by reason
