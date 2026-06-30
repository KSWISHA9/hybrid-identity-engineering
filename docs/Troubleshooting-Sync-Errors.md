# Troubleshooting Synchronization Errors

## Purpose

This document provides a structured troubleshooting process for Microsoft Entra Connect synchronization errors in the OmniVerse Enterprises hybrid identity environment.

## Business Scenario

OmniVerse Enterprises depends on Microsoft Entra Connect to synchronize identity data from Active Directory into Microsoft Entra ID.

When synchronization fails, users may lose access, duplicate objects may appear, or cloud identity data may become inaccurate.

The IAM team needs a repeatable troubleshooting workflow.

## Troubleshooting Framework

Use this order:

1. Confirm the user exists in Active Directory
2. Confirm the user is in synchronization scope
3. Confirm required attributes are populated
4. Check for duplicate UPN values
5. Check for duplicate proxyAddresses
6. Run delta sync
7. Review Synchronization Service Manager
8. Review export errors
9. Validate the cloud object
10. Document the root cause and fix

## Common Errors

### Duplicate UPN

A duplicate UPN means more than one object is using the same UserPrincipalName.

#### Validation

```powershell
Get-ADUser -Filter * -Properties UserPrincipalName |
Group-Object UserPrincipalName |
Where-Object { $_.Count -gt 1 -and $_.Name }
```

#### Resolution

Assign a unique UPN to each identity and rerun synchronization.

### Duplicate proxyAddresses

A duplicate proxy address means multiple objects share the same SMTP value.

#### Validation

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

#### Resolution

Remove or correct the duplicate proxy address and rerun synchronization.

### Duplicate Cloud Object

A duplicate cloud object may happen when Microsoft Entra ID creates a new synced user instead of matching the existing cloud user.

#### Likely Causes

- UPN mismatch
- Missing SMTP match
- Existing cloud account has conflicting attributes
- Soft match failed
- ImmutableID already set incorrectly

#### Resolution

Review soft match and hard match strategy before making changes.

### Deletion Threshold

Deletion threshold protects against accidental mass deletion in Microsoft Entra ID.

It may trigger when many objects are moved out of sync scope or deleted from Active Directory.

#### Resolution

- Stop and review the change
- Confirm whether deletions are expected
- Validate OU filtering
- Validate object counts
- Only proceed if the deletion event is intentional

### Scheduler Disabled

Synchronization may stop if the scheduler was disabled during maintenance or troubleshooting.

#### Validation

```powershell
Get-ADSyncScheduler
```

#### Resolution

```powershell
Set-ADSyncScheduler -SyncCycleEnabled $true
```

### Export Errors

Export errors occur when the sync engine cannot write changes to Microsoft Entra ID.

Common causes include:

- Duplicate attributes
- Permission issues
- Invalid attribute values
- Cloud object conflicts

## PowerShell Toolkit

### Start Delta Sync

```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```

### Start Initial Sync

```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```

### Check AD User Attributes

```powershell
Get-ADUser jdoe -Properties UserPrincipalName,mail,proxyAddresses,ObjectGUID |
Select-Object Name,SamAccountName,UserPrincipalName,mail,proxyAddresses,ObjectGUID
```

### Check Disabled Users

```powershell
Get-ADUser -Filter {Enabled -eq $false} -Properties UserPrincipalName,DistinguishedName |
Select-Object Name,SamAccountName,UserPrincipalName,DistinguishedName
```

## Validation Checklist

- Scheduler enabled
- Delta sync completed
- User is in synced OU
- UPN is unique
- proxyAddresses are unique
- mail attribute is correct
- ImmutableID is not incorrectly assigned
- Export completed successfully
- Microsoft Entra ID shows expected synced user
- No duplicate cloud object exists

## Screenshot Targets

Recommended screenshots:

- Duplicate attribute error
- Synchronization Service Manager error tab
- Export error details
- PowerShell duplicate UPN check
- PowerShell duplicate proxyAddresses check
- Successful delta sync
- Resolved synchronization status

## Lessons Learned

Synchronization troubleshooting should be evidence-based.

A strong IAM engineer does not randomly change attributes. They validate scope, matching, attributes, scheduler status, and export behavior before making corrections.

Most sync issues are caused by duplicate attributes, bad matching preparation, incorrect OU scope, or stale cloud objects.
