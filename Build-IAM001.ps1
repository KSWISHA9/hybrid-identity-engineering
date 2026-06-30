@'
# Hybrid Identity Engineering (IAM-001)

## Overview

This project documents a hybrid identity deployment connecting on-premises Active Directory to Microsoft Entra ID using Microsoft Entra Connect.

The goal is to demonstrate how enterprise identities are synchronized, validated, and troubleshot across on-prem and cloud identity platforms.

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