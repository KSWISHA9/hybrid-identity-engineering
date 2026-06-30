# Validation

The following screenshots document the deployment and validation of the hybrid identity environment from installation through synchronization.

---

## Validate the Active Directory Environment

Before deploying Microsoft Entra Connect, the enterprise Active Directory environment was validated to confirm the domain, organizational units, users, and infrastructure were operating correctly.

**Result**

The environment contained over 2,000 Active Directory identities and was ready for hybrid synchronization.

![Environment Overview](../screenshots/01-Environment-Overview.png)

---

## Configure the Authentication Method

Password Hash Synchronization was selected as the primary authentication method.

This allows users to authenticate to Microsoft Entra ID using their existing Active Directory passwords without requiring additional on-premises authentication infrastructure.

**Result**

Password Hash Synchronization was successfully configured.

![User Sign-In Method](../screenshots/10-User-Sign-In-Method.png)

---

## Connect the Active Directory Forest

The on-premises Active Directory forest was connected to Microsoft Entra Connect using enterprise administrator credentials.

This establishes the synchronization relationship between Active Directory and Microsoft Entra ID.

**Result**

The Active Directory forest was successfully added.

![Directory Added](../screenshots/13-Directory-Added.png)

---

## Configure Organizational Unit Filtering

Rather than synchronizing every object in Active Directory, synchronization was limited to selected Organizational Units.

This reduces unnecessary cloud objects while following enterprise synchronization best practices.

**Result**

Only required enterprise objects will synchronize to Microsoft Entra ID.

![Scoped OU Filtering](../screenshots/16-Scoped-OU-Filtering.png)

---

## Configure Identity Matching

Microsoft Entra Connect was configured to use the default source anchor configuration for identity matching.

This enables consistent identity synchronization between Active Directory and Microsoft Entra ID.

**Result**

Identity matching was configured successfully.

![Identity Matching](../screenshots/17-Identity-Matching-and-Source-Anchor.png)

---

## Configure Optional Features

Password Writeback was enabled to support future self-service password reset capabilities.

Additional features such as Exchange Hybrid and Device Writeback were intentionally left disabled because they were outside the scope of this project.

**Result**

Optional features were configured successfully.

![Optional Features](../screenshots/19-Optional-Features.png)

---

## Review the Final Configuration

Before installation completed, Microsoft Entra Connect presented a summary of the deployment configuration.

This provided one final validation before synchronization began.

**Result**

The deployment configuration was confirmed and applied.

![Ready to Configure](../screenshots/20-Ready-to-Configure.png)

---

## Validate Initial Synchronization

Synchronization Service Manager was used to verify that import, synchronization, and export operations completed successfully.

**Result**

The initial synchronization completed successfully with no critical synchronization errors.

![Synchronization Operations](../screenshots/21-Synchronization-Service-Manager-Operations.png)

---

## Verify Microsoft Entra ID

After synchronization completed, Microsoft Entra ID was reviewed to verify that Active Directory identities appeared correctly in the cloud tenant.

**Result**

Hybrid identities were successfully synchronized.

![Synchronized Users](../screenshots/22-Entra-Synchronized-Users.png)

---

## Perform Operational Delta Synchronization

A manual Delta Synchronization was initiated using PowerShell to validate operational administration of Microsoft Entra Connect.

```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```

**Result**

The synchronization cycle completed successfully, demonstrating normal operational management of the hybrid identity environment.

![Delta Sync PowerShell](../screenshots/23-Delta-Synchronization-PowerShell.png)
