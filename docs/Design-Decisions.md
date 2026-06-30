# Design Decisions

## Password Hash Synchronization

Password Hash Synchronization is used as the default authentication model because it is simple, resilient, and commonly used in enterprise hybrid identity environments.

## On-Premises Source of Authority

Active Directory remains the source of authority for synced identities.

User attributes should be corrected on-premises and then synchronized to Microsoft Entra ID.

## UPN Planning

UPNs should be routable and match the user's expected sign-in address.

## Attribute Hygiene

UPN and proxyAddresses values must be unique before synchronization.
