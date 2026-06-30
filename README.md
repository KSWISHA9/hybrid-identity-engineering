# Hybrid Identity Engineering (IAM-001)

## Overview

This project documents a hybrid identity deployment connecting on-premises Active Directory to Microsoft Entra ID using Microsoft Entra Connect.

The goal is to demonstrate how enterprise identities are synchronized, validated, and troubleshot across on-premises and cloud identity platforms.

## Business Scenario

OmniVerse Enterprise is expanding into Microsoft 365 and Azure while still maintaining an on-premises Active Directory environment.

The organization needs a secure hybrid identity model where users are mastered on-premises, synchronized to Microsoft Entra ID, and validated for cloud authentication and access.

## Environment

| Component | Value |
|---|---|
| On-Prem Directory | Active Directory |
| Cloud Directory | Microsoft Entra ID |
| Domain | corp.omniverse.com |
| Sync Tool | Microsoft Entra Connect |
| Authentication Model | Password Hash Synchronization |
| Source of Authority | On-Prem Active Directory |
| Automation | PowerShell |

## Topics Covered

- Microsoft Entra Connect
- Hybrid identity architecture
- Password Hash Synchronization
- Delta synchronization
- Full synchronization
- UPN planning
- Source anchor
- ImmutableID
- Soft match
- Hard match
- Duplicate UPN troubleshooting
- Duplicate proxyAddresses troubleshooting
- Sync validation

## Planned Workflow

```text
On-Prem Active Directory
        |
        v
Microsoft Entra Connect
        |
        v
Microsoft Entra ID
        |
        v
Synced cloud identities
```

## What This Solves

- Users need one identity across on-premises and cloud.
- Cloud identities must match on-premises accounts correctly.
- UPN and proxyAddresses conflicts can break synchronization.
- Identity teams need repeatable validation and troubleshooting steps.
- Hybrid identity must be documented before production rollout.

## Scripts

| Script | Purpose |
|---|---|
| 01-Start-DeltaSync.ps1 | Starts an Entra Connect delta sync cycle |
| 02-Verify-SyncScheduler.ps1 | Checks the Entra Connect sync scheduler |
| 03-Verify-ADUserAttributes.ps1 | Reviews on-premises identity attributes |
| 04-Get-ImmutableID.ps1 | Converts ObjectGUID to ImmutableID |
| 05-Find-DuplicateUPN.ps1 | Finds duplicate UPN values in AD |
| 06-Find-DuplicateProxyAddresses.ps1 | Finds duplicate proxyAddresses values |
| 07-Soft-Match-Checklist.ps1 | Documents soft match validation steps |
| 08-Hard-Match-Checklist.ps1 | Documents hard match validation steps |

## Skills Demonstrated

- Hybrid Identity
- Microsoft Entra ID
- Microsoft Entra Connect
- Active Directory
- Password Hash Synchronization
- ImmutableID / Source Anchor
- UPN Planning
- Attribute Hygiene
- PowerShell Troubleshooting
- Identity Lifecycle Management

## Project Outcome

By the end of this project, the lab will document:

- Entra Connect planning
- Hybrid identity configuration
- Sync validation
- Delta sync operations
- Soft match and hard match concepts
- Duplicate attribute troubleshooting
- PowerShell verification scripts

Created by **Keshawn Lynch**
