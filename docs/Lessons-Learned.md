# Lessons Learned

Hybrid identity depends heavily on clean identity attributes.

Duplicate UPNs, duplicate proxyAddresses values, and mismatched ImmutableID values can prevent successful synchronization.

Validation should happen before and after every sync cycle.
