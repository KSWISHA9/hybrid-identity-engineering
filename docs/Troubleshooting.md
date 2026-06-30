# Troubleshooting

## Common Hybrid Identity Issues

- Duplicate UPN
- Duplicate proxyAddresses
- Incorrect ImmutableID
- Cloud-only object conflicts
- Stale on-premises attributes
- Sync scheduler disabled
- Delta sync not running
- Object filtered from synchronization

## Troubleshooting Method

1. Validate on-premises attributes.
2. Confirm UPN and proxyAddresses uniqueness.
3. Confirm ObjectGUID and ImmutableID relationship.
4. Run a delta sync.
5. Validate cloud object state in Microsoft Entra ID.
6. Review synchronization errors.
