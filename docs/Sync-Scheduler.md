# Microsoft Entra Connect Sync Scheduler

## Purpose

This document explains the Microsoft Entra Connect synchronization scheduler and how OmniVerse Enterprises validates initial, delta, and full synchronization cycles.

## Business Scenario

After deploying Microsoft Entra Connect, OmniVerse Enterprises must ensure identity changes from Active Directory flow reliably into Microsoft Entra ID.

The IAM team needs to understand how synchronization runs, how to manually trigger sync cycles, and how to validate scheduler health.

## Key Concepts

### Initial Sync

Initial sync is the first synchronization cycle after Microsoft Entra Connect is configured.

It processes the selected Active Directory scope and creates or joins objects in Microsoft Entra ID.

### Delta Sync

Delta sync processes changes since the last synchronization cycle.

Examples include:

- New users
- Updated attributes
- Group membership changes
- Disabled accounts
- Changed proxyAddresses
- Changed UPN values

### Full Sync

Full sync reprocesses the synchronization rules and object data.

It is heavier than delta sync and should be used carefully.

Common reasons for full sync include:

- Synchronization rule changes
- OU filtering changes
- Major attribute flow changes
- Troubleshooting unresolved sync behavior

## PowerShell Commands

### Check Scheduler Status

```powershell
Get-ADSyncScheduler
```

### Start Delta Sync

```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```

### Start Initial Sync

```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```

### Disable Scheduler

```powershell
Set-ADSyncScheduler -SyncCycleEnabled $false
```

### Enable Scheduler

```powershell
Set-ADSyncScheduler -SyncCycleEnabled $true
```

## Validation

The engineering team should validate:

- Scheduler is enabled
- Sync cycle interval is expected
- Last sync completed successfully
- No sync cycle is currently stuck
- New AD changes appear in Microsoft Entra ID
- Synchronization Service Manager shows successful imports, synchronizations, and exports

## Screenshot Targets

Recommended screenshots:

- Get-ADSyncScheduler output
- Delta sync command
- Initial sync command
- Synchronization Service Manager operations
- Successful export to Microsoft Entra ID
- Sync error example if safely simulated

## Troubleshooting

| Issue | Likely Cause | Resolution |
|---|---|---|
| Scheduler disabled | Manual maintenance or previous troubleshooting | Re-enable scheduler |
| Delta sync does not run | ADSync service issue | Check service and event logs |
| Changes not appearing in cloud | Sync not completed or filtered OU | Validate sync scope and run delta sync |
| Full sync takes too long | Large environment or rule changes | Monitor Synchronization Service Manager |
| Export errors | Duplicate attributes or permission issues | Review export error details |

## Lessons Learned

The sync scheduler is a core operational component of hybrid identity.

Engineers should know when to use delta sync versus initial sync.

Full sync should not be used casually because it is more expensive and can affect large environments.

Healthy synchronization requires both automation and validation.
