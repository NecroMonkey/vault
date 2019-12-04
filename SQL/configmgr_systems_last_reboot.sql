DECLARE @get_Date DATETIME
SET @get_Date = GETDATE()

SELECT        v_R_System.Name0 as [Name], 
v_R_System.Full_Domain_Name0 as [Domain], 
v_R_System.Client_Version0 as [ClientVersion], 
v_R_System.Operating_System_Name_and0 as [OSType],
                         v_GS_OPERATING_SYSTEM.Caption0 + ' ' + v_GS_OPERATING_SYSTEM.OSArchitecture0 + ' ' + v_GS_OPERATING_SYSTEM.CSDVersion0 AS 'OS', 
                         v_GS_OPERATING_SYSTEM.InstallDate0 as [OSInstalls], 
						 v_GS_OPERATING_SYSTEM.LastBootUpTime0 as [LastBoot], 
						 v_ClientMachines.SiteCode as [SIteCode], 
                         v_CH_ClientSummary.LastOnline as [LastOnline], 
						 DATEDIFF(DAY, v_GS_OPERATING_SYSTEM.LastBootUpTime0, GETDATE()) as [Days]
FROM            v_R_System INNER JOIN
                         v_GS_OPERATING_SYSTEM ON v_R_System.ResourceID = v_GS_OPERATING_SYSTEM.ResourceID INNER JOIN
                         v_ClientMachines ON v_R_System.ResourceID = v_ClientMachines.ResourceID INNER JOIN
                         v_CH_ClientSummary ON v_R_System.ResourceID = v_CH_ClientSummary.ResourceID 