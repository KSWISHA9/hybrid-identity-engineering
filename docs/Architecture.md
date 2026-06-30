# Architecture

## Hybrid Identity Flow

```text
Active Directory
      |
      v
Microsoft Entra Connect
      |
      v
Microsoft Entra ID
      |
      v
Cloud Applications
```

## Core Components

| Component | Purpose |
|---|---|
| Active Directory | Source identity system |
| Microsoft Entra Connect | Synchronizes identities |
| Microsoft Entra ID | Cloud identity provider |
| Password Hash Sync | Enables cloud authentication |
| ImmutableID | Links cloud and on-premises objects |
| UPN | User sign-in identity |
| proxyAddresses | Email/proxy identity attributes |
