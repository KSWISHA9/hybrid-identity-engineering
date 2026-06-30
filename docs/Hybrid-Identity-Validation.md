\# Hybrid Identity Validation



\## Objective



After Microsoft Entra Connect is deployed, identity synchronization must be validated to ensure users are correctly synchronized between Active Directory and Microsoft Entra ID.



\---



\## Validation Checklist



\### Active Directory



\- Domain controller is healthy.

\- User account exists.

\- UserPrincipalName is correct.

\- proxyAddresses values are unique.

\- Account is enabled.



\---



\### Microsoft Entra Connect



\- Scheduler is enabled.

\- Last synchronization completed successfully.

\- No export errors.

\- No connector errors.



\---



\### Microsoft Entra ID



\- User exists.

\- Source = Windows Server AD.

\- UPN matches expected value.

\- Account is enabled.

\- Licenses assigned (if applicable).



\---



\## PowerShell Validation



Example commands:



```powershell

Get-ADSyncScheduler



Start-ADSyncSyncCycle -PolicyType Delta



Get-ADUser username -Properties UserPrincipalName,proxyAddresses,ObjectGUID

```



\---



\## Common Failure Indicators



\- Duplicate UPN

\- Duplicate proxyAddresses

\- Incorrect ImmutableID

\- Filtered OU

\- Cloud-only object conflict

\- Sync scheduler disabled



\---



\## Success Criteria



A successful synchronization results in:



\- Matching user identity

\- Matching UPN

\- Correct source authority

\- No synchronization errors

\- Successful cloud authentication



