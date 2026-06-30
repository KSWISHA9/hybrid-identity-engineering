# IAM-001 Hybrid Identity Engineering

## Project Summary

IAM-001 documents and validates a Microsoft Entra hybrid identity deployment for OmniVerse Enterprises.

This project focuses on synchronizing on-premises Active Directory identities into Microsoft Entra ID using Microsoft Entra Connect.

## Business Scenario

OmniVerse Enterprises has an established Active Directory environment from INFRA-001 and now needs to extend identity into Microsoft Entra ID.

The organization requires a reliable hybrid identity foundation that supports Microsoft 365, cloud authentication, identity lifecycle automation, Conditional Access, privileged access governance, and future Terraform-managed Azure infrastructure.

## Engineering Scope

This project covers:

- Microsoft Entra Connect planning
- Authentication method selection
- Password Hash Synchronization
- Pass-through Authentication
- Federation overview
- Synchronization scheduler
- Delta sync
- Initial sync
- Full sync
- OU filtering
- Connector Space
- Metaverse
- Soft match
- Hard match
- ImmutableID
- Source anchor
- Duplicate attribute troubleshooting
- Deletion threshold awareness
- Validation and screenshots

## Repository Structure

```text
IAM-001-Hybrid-Identity-Engineering/
│
├── README.md
├── docs/
├── scripts/
├── screenshots/
├── diagrams/
└── exports/
```

## Key Documents

- `Architecture.md`
- `Design-Decisions.md`
- `Entra-Connect-Planning.md`
- `Authentication-Methods.md`
- `Soft-Match-vs-Hard-Match.md`
- `Sync-Scheduler.md`
- `OU-Filtering.md`
- `Connector-Space-and-Metaverse.md`
- `Troubleshooting-Sync-Errors.md`
- `Hybrid-Identity-Validation.md`
- `Screenshot-Checklist.md`
- `Final-Validation.md`
- `Terraform-Connection.md`

## Key Scripts

- `Start-DeltaSync.ps1`
- `Verify-ADSyncScheduler.ps1`
- `Verify-ADUserHybridAttributes.ps1`
- `Get-ImmutableID.ps1`
- `Find-DuplicateUPN.ps1`
- `Find-DuplicateProxyAddresses.ps1`

## Interview Value

This project demonstrates that I understand hybrid identity beyond basic synchronization.

It shows planning, architecture, authentication design, identity matching, troubleshooting, PowerShell validation, and enterprise documentation.

## Connection to Future Projects

IAM-001 becomes the identity foundation for:

- IAM-002 Identity Lifecycle Automation
- IAM-003 Conditional Access & Zero Trust
- IAM-004 Identity Governance & PIM
- TERRAFORM-001 Infrastructure as Code
- SEC-001 Microsoft Sentinel SOC
