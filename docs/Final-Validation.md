# Final Validation

## Purpose

This document defines the final validation process for IAM-001 Hybrid Identity Engineering.

The goal is to prove that the hybrid identity deployment is configured, synchronized, documented, and ready for interview review.

## Validation Areas

### Active Directory

Validate:

- Users exist in the correct OUs
- UPNs are correctly formatted
- mail attributes are populated
- proxyAddresses are unique
- Disabled and terminated users are excluded when required
- Service accounts are reviewed separately

### Microsoft Entra Connect

Validate:

- Correct authentication method selected
- Correct OU filtering configured
- Scheduler is enabled
- Delta sync works
- Initial sync works when required
- Synchronization Service Manager shows successful operations

### Microsoft Entra ID

Validate:

- Expected users are synced
- Duplicate users are not created
- Cloud users show correct source
- Sign-in names are correct
- Licenses remain assigned correctly
- No unexpected privileged accounts are synced

### Troubleshooting

Validate documented examples for:

- Duplicate UPN
- Duplicate proxyAddresses
- Duplicate cloud object
- Deletion threshold
- Export errors
- Scheduler disabled

## PowerShell Validation Commands

### Scheduler

```powershell
Get-ADSyncScheduler
```

### Delta Sync

```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```

### AD Attribute Review

```powershell
Get-ADUser jdoe -Properties UserPrincipalName,mail,proxyAddresses,ObjectGUID |
Select-Object Name,SamAccountName,UserPrincipalName,mail,proxyAddresses,ObjectGUID
```

### Duplicate UPN Review

```powershell
Get-ADUser -Filter * -Properties UserPrincipalName |
Group-Object UserPrincipalName |
Where-Object { $_.Count -gt 1 -and $_.Name }
```

### Duplicate proxyAddresses Review

```powershell
Get-ADUser -Filter * -Properties proxyAddresses |
ForEach-Object {
    foreach ($proxy in $_.proxyAddresses) {
        [PSCustomObject]@{
            SamAccountName = $_.SamAccountName
            ProxyAddress   = $proxy
        }
    }
} |
Group-Object ProxyAddress |
Where-Object { $_.Count -gt 1 }
```

## Completion Criteria

IAM-001 is complete when:

- README explains the business scenario and technical design
- Architecture document is complete
- Entra Connect planning document is complete
- Authentication method document is complete
- Soft match and hard match document is complete
- Sync scheduler document is complete
- OU filtering document is complete
- Connector Space and Metaverse document is complete
- Troubleshooting document is complete
- Scripts are realistic and organized
- Screenshot checklist is complete
- Lessons learned are written
- Repository is clean and professional

## Lessons Learned

Final validation turns a lab into an engineering project.

The purpose is not only to show that the technology works, but to prove that the engineer can design, implement, validate, troubleshoot, and explain a production-style hybrid identity solution.
