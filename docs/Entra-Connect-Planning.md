\# Microsoft Entra Connect Planning



\## Purpose



Microsoft Entra Connect synchronizes identities from on-premises Active Directory to Microsoft Entra ID.



In this project, Active Directory remains the source of authority. Microsoft Entra ID receives synchronized user identities for cloud authentication and Microsoft 365/Azure access.



\## Business Goal



OmniVerse Enterprise needs users to sign in to cloud services using the same identity they use on-premises.



\## Selected Authentication Method



Password Hash Synchronization is selected for the baseline deployment.



\## Why Password Hash Sync



\- Simple to deploy

\- Highly available

\- Does not require on-premises authentication agents

\- Supports cloud authentication even if on-premises infrastructure is temporarily unavailable



\## Sync Scope



The sync scope should include production user OUs and exclude unnecessary lab/staging OUs.



Included:



\- Department Users

\- Service Accounts if required for cloud services

\- Privileged Accounts only if explicitly required



Excluded:



\- Disabled Users

\- Staging

\- Test objects

\- Unused service accounts



\## Source Anchor



The source anchor is the attribute used to link the on-premises AD object to the cloud object.



Common source anchor:



\- msDS-ConsistencyGuid

\- ObjectGUID



\## Identity Matching



\### Soft Match



Soft match links an on-premises AD object to an existing cloud object using matching verified email/proxy attributes.



\### Hard Match



Hard match links an on-premises AD object to an existing cloud object using ImmutableID.



\## Risks



\- Duplicate UPN values

\- Duplicate proxyAddresses values

\- Cloud-only users with conflicting attributes

\- Incorrect ImmutableID

\- Wrong OU filtering

\- Accidental sync of disabled or test accounts



\## Validation



Before syncing:



\- Validate UPN uniqueness

\- Validate proxyAddresses uniqueness

\- Confirm routable UPN suffix

\- Confirm sync scope

\- Confirm no duplicate cloud objects



After syncing:



\- Confirm user appears in Microsoft Entra ID

\- Confirm source is Windows Server AD

\- Confirm UPN matches expected sign-in name

\- Confirm sync errors are clear

