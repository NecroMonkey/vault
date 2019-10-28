SELECT DISTINCT 
sysr.Netbios_Name0,
ipr.Name as [Boundary],
ipr.BoundaryType as [Type],
bg.Name AS [Boundary Group]
FROM     v_R_System AS sysr INNER JOIN
                  System_IP_Address_ARR AS ip ON ip.ItemKey = sysr.ResourceID AND ip.NumericIPAddressValue <> 0 INNER JOIN
                  v_RA_System_IPSubnets AS sub ON sub.ResourceID = sysr.ResourceID LEFT OUTER JOIN
                  v_RA_System_IPv6Prefixes AS v6 ON v6.ResourceID = sysr.ResourceID INNER JOIN
                  BoundaryEx AS ipr ON ipr.BoundaryType = 3 AND ip.NumericIPAddressValue BETWEEN ipr.NumericValueLow AND ipr.NumericValueHigh OR
                  ipr.BoundaryType = 1 AND ipr.Value = sysr.AD_Site_Name0 OR
                  ipr.BoundaryType = 0 AND ipr.Value = sub.IP_Subnets0 OR
                  ipr.BoundaryType = 2 AND ipr.Value = v6.IPv6_Prefixes0 INNER JOIN
                  vSMS_BoundaryGroupMembers as bgm ON ipr.BoundaryID = bgm.BoundaryID INNER JOIN
                  vSMS_BoundaryGroup as bg ON bgm.GroupID = bg.GroupID
GROUP BY sysr.Netbios_Name0, ipr.Name, ipr.BoundaryType, bg.Name
ORDER BY sysr.Netbios_Name0, ipr.Name, bg.Name

