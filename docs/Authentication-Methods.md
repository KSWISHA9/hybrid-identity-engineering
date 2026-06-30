# Authentication Methods

## Purpose

This document explains the primary authentication methods used in a Microsoft Entra hybrid identity deployment: Password Hash Synchronization, Pass-through Authentication, and Federation.

The goal is to help OmniVerse Enterprises choose an authentication model that balances security, availability, user experience, and operational complexity.

## Business Scenario

OmniVerse Enterprises is extending its on-premises Active Directory identity system into Microsoft Entra ID. Users need a consistent sign-in experience across on-premises and cloud applications.

The identity team must decide how users will authenticate after synchronization is enabled.

## Authentication Options

### Password Hash Synchronization

Password Hash Synchronization, also called PHS, synchronizes a hash of the user's on-premises password hash to Microsoft Entra ID.

Users authenticate directly against Microsoft Entra ID for cloud services.

#### Benefits

- Simple to deploy
- High availability
- No dependency on on-premises authentication infrastructure during cloud sign-in
- Works well with Microsoft Entra security features
- Recommended for many hybrid environments

#### Engineering Considerations

PHS does not synchronize the actual password. It synchronizes a derived hash that allows Microsoft Entra ID to validate cloud authentication.

This model reduces dependency on on-premises infrastructure and supports strong cloud-based protections.

### Pass-through Authentication

Pass-through Authentication, also called PTA, allows users to sign in to cloud services using their on-premises password without storing password hashes in Microsoft Entra ID.

Authentication requests are passed through lightweight on-premises agents.

#### Benefits

- Password validation happens against on-premises Active Directory
- Useful when organizations do not want password hashes stored in the cloud
- Can provide a familiar hybrid authentication model

#### Engineering Considerations

PTA requires healthy on-premises agents. Multiple agents should be deployed for high availability.

If the agents are unavailable, cloud authentication can be impacted.

### Federation

Federation redirects authentication to a trusted identity provider such as AD FS or another federation service.

Microsoft Entra ID trusts the federation provider to authenticate the user.

#### Benefits

- Supports advanced enterprise authentication scenarios
- Can integrate with existing federation infrastructure
- Useful for complex legacy environments

#### Engineering Considerations

Federation adds infrastructure complexity. The federation service becomes a critical authentication dependency.

For many modern environments, PHS or PTA is preferred unless a specific federation requirement exists.

## Recommended OmniVerse Approach

For IAM-001, OmniVerse Enterprises should document PHS as the preferred default authentication method.

PTA should be documented as an alternative design.

Federation should be documented as a legacy or advanced enterprise scenario.

## Architecture Decision

OmniVerse Enterprises will use Password Hash Synchronization for the baseline hybrid identity design because it provides:

- Simpler operations
- Strong cloud availability
- Reduced on-premises dependency
- Easier troubleshooting
- Better fit for a modern Microsoft Entra environment

## Validation

Validation should confirm:

- Microsoft Entra Connect is configured with the expected authentication method
- Users can sign in to Microsoft Entra ID
- Password changes sync successfully
- Sign-in logs show expected authentication behavior
- No unexpected federation dependency exists

## Troubleshooting

| Issue | Likely Cause | Resolution |
|---|---|---|
| Users cannot sign in after password change | Password hash has not synced yet | Run delta sync and verify scheduler |
| PTA sign-ins failing | PTA agents unavailable | Check agent health and deploy additional agents |
| Federation redirect fails | AD FS or federation provider issue | Validate federation service health |
| Users authenticate inconsistently | Mixed configuration or stale settings | Review Entra Connect authentication configuration |

## Lessons Learned

Authentication method selection affects reliability, security, and support workload.

PHS is often the best engineering default because it reduces infrastructure dependency and supports strong cloud authentication.

PTA and Federation should be used when business or compliance requirements justify the additional operational responsibility.
