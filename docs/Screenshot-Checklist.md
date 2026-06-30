# IAM-001 Screenshot Checklist

## Purpose

This document defines the screenshots needed to prove the IAM-001 Hybrid Identity Engineering project was implemented and validated.

Each screenshot should have a purpose. Screenshots should not be random.

## Required Screenshots

### Microsoft Entra Connect

- Entra Connect welcome or configuration screen
- Authentication method selection
- OU filtering selection
- Optional features selection
- Ready to configure screen
- Configuration complete screen

### Synchronization Operations

- Synchronization Service Manager overview
- AD import operation
- Microsoft Entra ID export operation
- Successful delta sync
- Successful initial sync
- Connector Space search result
- Metaverse object view

### PowerShell Validation

- `Get-ADSyncScheduler`
- `Start-ADSyncSyncCycle -PolicyType Delta`
- AD user attribute validation
- Duplicate UPN check
- Duplicate proxyAddresses check
- ImmutableID review

### Troubleshooting Evidence

- Duplicate UPN error example
- Duplicate proxyAddresses error example
- Export error details
- Deletion threshold warning
- Scheduler disabled example
- Resolved sync success screen

## Screenshot Naming Standard

Use clear names:

```text
01-entra-connect-authentication-method.png
02-ou-filtering-selection.png
03-sync-service-manager-success.png
04-get-adsyncscheduler-output.png
05-delta-sync-success.png
06-duplicate-upn-error.png
07-duplicate-proxyaddresses-error.png
08-metaverse-object-view.png
09-connector-space-search.png
10-successful-cloud-sync.png
```

## Screenshot Documentation Format

Each screenshot should be referenced in the README or supporting documentation with:

- What the screenshot shows
- Why it matters
- What was validated

## Example

```markdown
![Delta Sync Success](../screenshots/05-delta-sync-success.png)

This screenshot validates that a manual delta synchronization cycle was triggered successfully after updating an on-premises AD user attribute.
```

## Lessons Learned

Screenshots are proof of engineering work.

A good portfolio screenshot should show implementation, validation, troubleshooting, or a technical decision.

Random screenshots do not add value. Evidence-based screenshots make the repository interview-ready.
