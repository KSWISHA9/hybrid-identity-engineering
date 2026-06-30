# Hybrid Identity Architecture Diagram

```mermaid
flowchart TD
A[On-Prem AD] --> B[Microsoft Entra Connect]
B --> C[Connector Space]
C --> D[Metaverse]
D --> E[Microsoft Entra ID]
E --> F[Microsoft 365 / Cloud Apps]
```
