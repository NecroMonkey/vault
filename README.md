# ReadMe

I am a ConfigMan engineer and this is where I will be keeping my scripts, SQL queries, SSRS reports, and other things in the hopes that they will benefit the community.

## Contents

### ./

**README.md** - This file

**Templates.code-snippets** - The code snippets I use in VSCode

### ./ConfigMan-Run-Scripts

**check-ARP-for-installed-software.ps1** - Checks Add/Remove Programs (Programs and Features) for installed software

**check-for-KB.ps1** - Checks for installed KB and retuens dated installed

**check-services-start-type.ps1** - Checks the startup type of a service

**check-services-status.ps1** - Checks the status of a service

### ./SSRS-Reports/ComplianceSettings-OverallStatusReports/

**Compliance Settings - Overall Status for a System.rdl** - Third level report that gives baseline and configuration item compliance for a sigle system. Baseline links back to *Compliance Settings - Overall Status of Baseline* and individual CIs link to *Compliance Settings - Overall Status of Configuration Item*

**Compliance Settings - Overall Status of Baseline.rdl** - Top level report that gives overall compliance of a ConfigMan baseline. Individual CIs link to *Compliance Settings - Overall Status of Configuration Item*

**Compliance Settings - Overall Status of Configuration Item.rdl** - Second level report that gives compliance of configuration item within a baseline.  Baseline links back to *Compliance Settings - Overall Status of Baseline* and individual system links to *Compliance Settings - Overall Status for a System*