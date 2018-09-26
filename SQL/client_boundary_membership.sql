SELECT distinct
sysr.ResourceID,
ipr.BoundaryID
into t_PSJH_BoundaryMembers
FROM v_R_System sysr
JOIN System_IP_Address_ARR ip ON ip.ItemKey = sysr.ResourceID AND ip.NumericIPAddressValue <> 0     
JOIN v_RA_System_IPSubnets sub ON sub.ResourceID = sysr.ResourceID      
LEFT JOIN v_RA_System_IPv6Prefixes v6 ON v6.ResourceID = sysr.ResourceID
JOIN BoundaryEx AS ipr ON 
-- Check BoundaryType 3 (IPRANGE)
(ipr.BoundaryType = 3 AND ip.NumericIPAddressValue BETWEEN ipr.NumericValueLow AND ipr.NumericValueHigh)
-- Check BoundaryType 1 (ADSITE)
OR (ipr.BoundaryType = 1 AND ipr.Value = sysr.AD_Site_Name0) 
-- Check BoundaryType 0 (IPSUBNET)
OR (ipr.BoundaryType = 0 AND ipr.Value = sub.IP_Subnets0)
-- Check BoundaryType 2 (IPv6)
OR (ipr.BoundaryType = 2 AND ipr.Value = v6.IPv6_Prefixes0)
order by sysr.ResourceID
