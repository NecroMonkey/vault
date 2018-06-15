# ReadMe

I am a ConfigMan engineer and this is where I will be keeping my scripts, SQL queries, SSRS reports, and other things in the hopes that they will benefit the community.

## Contents

### ./
**Templates.code-snippets** - The code snippets I use in VSCode

### ./ConfigMan-Run-Scripts
**check-ARP-for-installed-software.ps1** - Checks Add/Remove Programs (Programs and Features) for installed software
**check-for-KB** - Checks for installed KB and retuens dated installed

### ./SSRS-Reports/ComplianceSettings-OverallStatusReports/
**Compliance Settings - Overall Status for a System** - Third level report that gives baseline and configuration item compliance for a sigle system. Baseline links back to *Compliance Settings - Overall Status of Baseline* and individual CIs link to *Compliance Settings - Overall Status of Configuration Item*

**Compliance Settings - Overall Status of Baseline** - Top level report that gives overall compliance of a ConfigMan baseline. Individual CIs link to *Compliance Settings - Overall Status of Configuration Item*

**Compliance Settings - Overall Status of Configuration Item** - Second level report that gives compliance of configuration item within a baseline.  Baseline links back to *Compliance Settings - Overall Status of Baseline* and individual system links to *Compliance Settings - Overall Status for a System*