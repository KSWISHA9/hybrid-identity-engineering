# OU Filtering

## Purpose

This document explains how Organizational Unit filtering controls which Active Directory objects are synchronized to Microsoft Entra ID.

## Business Scenario

OmniVerse Enterprises has multiple Active Directory OUs for employees, contractors, service accounts, privileged accounts, test accounts, and disabled users.

Not every object should synchronize to Microsoft Entra ID.

The IAM team must define a clean synchronization scope to prevent unnecessary or risky objects from appearing in the cloud.

## Design Goals

OU filtering should:

- Synchronize only approved production identities
- Exclude disabled or terminated users
- Exclude test accounts unless needed
- Exclude certain service accounts
- Reduce synchronization noise
- Prevent accidental cloud object creation
- Support clean lifecycle management

## Example OU Scope

Included:

- `OU=Employees,OU=HQ,DC=omniverse,DC=local`
- `OU=Contractors,OU=HQ,DC=omniverse,DC=local`
- `OU=IT,OU=Departments,DC=omniverse,DC=local`

Excluded:

- `OU=Terminated,DC=omniverse,DC=local`
- `OU=Disabled,DC=omniverse,DC=local`
- `OU=LabUsers,DC=omniverse,DC=local`
- `OU=ServiceAccounts,DC=omniverse,DC=local`
- `OU=BreakGlass,DC=omniverse,DC=local`

## Architecture Decision

OmniVerse Enterprises will use OU filtering to synchronize only active business identities required for Microsoft Entra ID and Microsoft 365 access.

Privileged and service accounts require separate review before synchronization.

## Risks

Poor OU filtering can cause:

- Unwanted cloud users
- Duplicate accounts
- License waste
- Exposure of privileged accounts
- Accidental deletion events if objects move out of scope
- Deletion threshold incidents

## Validation

Before changing OU filtering:

- Export current OU selection
- Confirm object count
- Identify users that will be added
- Identify users that will be removed
- Review deletion threshold risk
- Communicate expected impact

After changing OU filtering:

- Run initial sync if required
- Review Synchronization Service Manager
- Confirm expected users are synchronized
- Confirm excluded users are not synchronized
- Check for deletion threshold warnings
- Validate no critical users were removed

## PowerShell Review

### Count Users in an OU

```powershell
Get-ADUser -SearchBase "OU=Employees,OU=HQ,DC=omniverse,DC=local" -Filter * |
Measure-Object
```

### Review Disabled Users

```powershell
Get-ADUser -Filter {Enabled -eq $false} -Properties DistinguishedName |
Select-Object Name,SamAccountName,DistinguishedName
```

### Review Service Accounts

```powershell
Get-ADUser -SearchBase "OU=ServiceAccounts,DC=omniverse,DC=local" -Filter * |
Select-Object Name,SamAccountName,Enabled
```

## Screenshot Targets

Recommended screenshots:

- Entra Connect OU filtering page
- Selected OUs
- Excluded OUs
- PowerShell OU count validation
- Synchronization Service Manager after OU filtering change
- Deletion threshold warning example if safely simulated

## Troubleshooting

| Issue | Likely Cause | Resolution |
|---|---|---|
| User not syncing | User is in excluded OU | Move user or update filtering |
| Too many users syncing | OU scope too broad | Narrow OU selection |
| Deletion threshold triggered | Many users moved out of scope | Review filtering change before allowing deletes |
| Service accounts syncing | Service account OU included | Exclude service account OU or create policy |
| Disabled users in cloud | Disabled OU still included | Review lifecycle process |

## Lessons Learned

OU filtering is both a technical and business control.

It determines which identities are allowed to exist in cloud identity systems.

Filtering changes should be treated like production change management because a bad scope decision can cause mass cloud deletions or unwanted cloud exposure.
