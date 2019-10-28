drop table if exists ##temp1
drop table if exists ##temp2

SELECT distinct sysr.Name0,
sysr.ResourceID, ipr.Name as [Boundary],
ipr.Value
into ##temp1
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

select rsys.Name0, rsys.ResourceID,
"Content Source Type" = CASE cdhs.DistributionPointType
WHEN 1 THEN 'Cloud DP (Distribution Point)'
WHEN 2 THEN 'Management Point'
WHEN 3 THEN 'Peer Cache'
WHEN 4 THEN 'DP (Distribution Point)'
WHEN 5 THEN 'BranchCache'
WHEN 6 THEN 'Delivery Optimization Peer'
WHEN 7 THEN 'Delivery Optimization Cache Server'
WHEN 8 THEN 'Microsoft Update'
END,
packages.Name as [Content],
cdhs.ContentID,
CAST(SUM(cast(cdhs.BytesDownloaded as float)) / 1073741824 AS DECIMAL(10,2)) as [GB]
into ##temp2
from
v_R_System as rsys
join ClientDownloadHistory as cdh on rsys.ResourceID = cdh.ClientId
join ClientDownloadHistorySources as cdhs on cdh.id = cdhs.DownloadHistoryID
join ClientDownloadHistoryBoundaryGroups as cdhbg on cdh.id = cdhbg.DownloadHistoryID JOIN
                         v_FullCollectionMembership AS a ON rsys.ResourceID = a.ResourceID JOIN
                         v_Collection AS b ON b.CollectionID = a.CollectionID LEFT JOIN CI_Contentpackages CI on CI.Content_UniqueID = cdhs.ContentID 
JOIN smspackages packages on packages.PkgID = ISNULL(CI.PkgID,cdhs.ContentId)
where (b.CollectionID = 'SMSDM003')
group by rsys.Name0, rsys.ResourceID, cdhs.DistributionPointType, packages.Name, cdhs.ContentID
order by rsys.Name0, rsys.ResourceID, cdhs.DistributionPointType, packages.Name, cdhs.ContentID

select
t1.Name0, t1.Boundary, t1.Value, t2.[Content Source Type], t2.Content, t2.GB
from ##temp1 as t1 join
##temp2 as t2 on t1.ResourceID = t2.ResourceID

drop table if exists ##temp1
drop table if exists ##temp2
