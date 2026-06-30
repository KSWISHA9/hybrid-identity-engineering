# Check for duplicate UPN values in Active Directory

Get-ADUser -Filter * -Properties UserPrincipalName |
Group-Object UserPrincipalName |
Where-Object { $_.Count -gt 1 -and $_.Name } |
Select-Object Name,Count
