# Sync Cycle Flow

```mermaid
flowchart LR
A[AD Change] --> B[Delta Import]
B --> C[Delta Sync]
C --> D[Export to Entra ID]
D --> E[Cloud Object Updated]
```
