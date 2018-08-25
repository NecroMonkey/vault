SELECT        
vSMS_Boundary.DisplayName, vSMS_Boundary.BoundaryID as id,
STUFF(vSMS_Boundary.value, LEN(vSMS_Boundary.value), 1, '1') + '-' + STUFF(vSMS_Boundary.value, LEN(vSMS_Boundary.value), 1, '254') as range,
vSMS_BoundaryGroup.GroupID as bgid
FROM            vSMS_Boundary INNER JOIN
                         vSMS_BoundaryGroupMembers ON vSMS_Boundary.BoundaryID = vSMS_BoundaryGroupMembers.BoundaryID INNER JOIN
                         vSMS_BoundaryGroup ON vSMS_BoundaryGroupMembers.GroupID = vSMS_BoundaryGroup.GroupID
where vSMS_Boundary.BoundaryType = '0' and vSMS_Boundary.Value like '%.0'
order by vSMS_Boundary.BoundaryID