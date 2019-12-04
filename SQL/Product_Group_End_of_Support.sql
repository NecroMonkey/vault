DECLARE @get_Date DATETIME
SET @get_Date = GETDATE()

SELECT Category, 
GroupName, 
MainstreamSupportEndDateAsDate, 
[Mainstream Support Days Left] = case
when DATEDIFF(DAY, @get_Date, MainstreamSupportEndDateAsDate) > '0' then DATEDIFF(DAY, @get_Date, MainstreamSupportEndDateAsDate)
else '0'
end,
ExtendedSupportEndDateAsDate, 
[Extended Support Days Left] = case
when DATEDIFF(DAY, @get_Date, ExtendedSupportEndDateAsDate) > '0' then DATEDIFF(DAY, @get_Date, ExtendedSupportEndDateAsDate)
else '0'
end,
InstallCount, 
ScanData0  
FROM 
v_LifecycleDetectedGroups
--where Category = 'ConfigMgr'
Order by Category, GroupName
