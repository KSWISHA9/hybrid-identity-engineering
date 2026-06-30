# Connector Space and Metaverse

## Purpose

This document explains the role of Connector Space and Metaverse in Microsoft Entra Connect synchronization.

Understanding these components helps engineers troubleshoot identity joins, duplicate objects, attribute flows, and synchronization errors.

## Business Scenario

OmniVerse Enterprises is synchronizing identities from on-premises Active Directory to Microsoft Entra ID.

When sync errors occur, the IAM team needs to understand where object data is imported, joined, transformed, and exported.

## Key Concepts

### Connector Space

A Connector Space stores object data from a connected directory.

Examples:

- Active Directory Connector Space
- Microsoft Entra ID Connector Space

Objects are imported into Connector Space before they are joined or projected into the Metaverse.

### Metaverse

The Metaverse is the central identity representation inside the synchronization engine.

It combines identity data from connected systems and applies synchronization rules to determine how objects should flow.

### Join

A join happens when an imported object matches an existing Metaverse object.

### Projection

A projection happens when an imported object creates a new Metaverse object.

### Export

An export sends changes from the synchronization engine to the connected target system, such as Microsoft Entra ID.

## Synchronization Flow

1. Import from Active Directory
2. Process object in AD Connector Space
3. Join or project object into Metaverse
4. Apply synchronization rules
5. Stage export to Microsoft Entra ID Connector Space
6. Export changes to Microsoft Entra ID

## Why This Matters

Connector Space and Metaverse troubleshooting helps identify:

- Why a user did not synchronize
- Why a duplicate object was created
- Which attributes are flowing
- Which connector is causing an error
- Whether an object joined or projected
- Whether an export is pending or failing

## Example Investigation

A user named `jdoe` is not appearing correctly in Microsoft Entra ID.

The engineer should check:

- AD object exists
- AD object is in synchronization scope
- AD Connector Space import succeeded
- Object joined or projected correctly
- Metaverse object has expected attributes
- Export to Microsoft Entra ID succeeded
- No duplicate attribute error exists

## Validation Steps

- Open Synchronization Service Manager
- Select the AD connector
- Review import operations
- Search Connector Space for the affected user
- Review object properties
- Review Metaverse object
- Confirm expected attribute flow
- Review Microsoft Entra ID connector export results

## Screenshot Targets

Recommended screenshots:

- Synchronization Service Manager
- AD Connector Space search
- Metaverse object view
- Attribute flow view
- Pending export
- Successful export
- Export error details

## Troubleshooting

| Issue | Likely Cause | Resolution |
|---|---|---|
| User missing from cloud | Not projected or exported | Check OU scope and sync rules |
| Duplicate user created | Projection occurred instead of join | Review soft match attributes |
| Attribute not updating | Attribute flow rule issue | Review synchronization rules |
| Export error | Duplicate UPN or proxy address | Resolve duplicate attribute |
| Object stuck pending export | Connector or permission issue | Review export operation details |

## Lessons Learned

The sync engine is not a black box.

Connector Space and Metaverse views give engineers evidence when troubleshooting identity problems.

Strong IAM engineers understand where identity data enters, transforms, joins, and exports.
