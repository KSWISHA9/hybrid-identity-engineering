# Wolf-Pak Internal Asset Manager (WIAM)

A secure internal dashboard for managing project assets across teams. Built with Node.js, Express, Microsoft Entra ID, and SQLite.

---

## Overview

The original application had zero security — any user could read or delete any team's data with no authentication, no roles, and no audit trail. This implementation adds a full Identity and Access Management (IAM) layer across every architectural layer.

---

## Vulnerabilities Fixed

| Before | After |
|--------|-------|
| Any request returned ALL assets to ANYONE | JWT verification required on every route |
| Anyone could DELETE any asset | RBAC + team isolation on all write routes |
| Tokens stored in localStorage (XSS risk) | HttpOnly + SameSite cookies only |
| No POST or PUT routes existed | Full CRUD with role enforcement |
| No audit trail of any kind | Persistent SQLite audit log |
| Plain text passwords in code | bcrypt hashed passwords |
| No rate limiting on login | 10 attempts per 15 min per IP |
| No input validation | Zod schema validation on all routes |
| No security headers | Helmet applied globally |
| No identity provider | Microsoft Entra ID OAuth2 |

---

## Architecture

```
wiam/
├── middleware/
│   ├── auth.js        # JWT verification — runs on every protected route
│   ├── rbac.js        # Role + team access control
│   └── logger.js      # Audit logging to SQLite
├── database.js        # SQLite setup + seeding
├── server.js          # Express server — all routes
├── frontend.html      # Branded dashboard UI
└── .env               # Entra ID credentials (never commit this)
```

**Request flow:**

```
Browser → Cookie → verifyToken → checkRole → checkTeam → auditLog → Route handler
```

Every request hits verifyToken first. If the token is missing or invalid, the request is rejected immediately with a 401. Role and team checks run after identity is confirmed.

---

## Roles & Permissions

| Action | Viewer | Editor | GlobalAdmin |
|--------|--------|--------|-------------|
| GET /api/assets | Own team only | Own team only | All teams |
| POST /api/assets | No | Own team | All teams |
| PUT /api/assets/:id | No | Own team | All teams |
| DELETE /api/assets/:id | No | Own team | All teams |
| GET /api/admin/logs | No | No | Yes |
| GET /api/me | Yes | Yes | Yes |

---

## Security Controls

### Phase 1 — Identity Verification
Microsoft Entra ID handles authentication via OAuth2 using @azure/msal-node. After login, the server issues a signed JWT containing the user's identity, role, and team. A local bcrypt login route is also available for non-Microsoft accounts.

### Phase 2 — RBAC & ABAC
Two middleware functions enforce access control:
- checkRole(allowedRoles) — blocks users whose role is not in the allowed list (403)
- checkTeam — blocks users from accessing assets belonging to another team (403). GlobalAdmins bypass this check.

### Phase 3 — Session Hardening
Tokens are stored in HttpOnly cookies — invisible to JavaScript entirely. SameSite=Strict blocks cross-site request forgery. Secure=true is enabled automatically in production via NODE_ENV=production.

### Phase 4 — Audit Logging
Every sensitive action is logged to SQLite with:
- Timestamp
- User ID and username
- Source IP address
- Action (HTTP method + endpoint)
- Result (SUCCESS or DENY)

Logs are accessible only to GlobalAdmin users via GET /api/admin/logs.

### Bonus Controls
- Deny by default — every route is blocked unless explicitly listed as public
- bcrypt — passwords hashed at cost factor 10
- Rate limiting — max 10 login attempts per IP per 15 minutes
- Zod — request body validation on all write routes
- Helmet — security headers including X-Frame-Options and X-Content-Type-Options

---

## Test Cases

All 13 tests passed manually on 26th March 2026.

| ID | Action | User | Expected | Result |
|----|--------|------|----------|--------|
| T1 | Unauthenticated GET /api/assets | None | 401 Not logged in | PASS |
| T2 | Viewer DELETE /api/assets/1 | alice (Viewer) | 403 Insufficient role | PASS |
| T3 | Viewer GET /api/assets | alice (Viewer) | Alpha assets only | PASS |
| T4 | Editor DELETE other team asset | bob (Editor) | 403 Wrong team | PASS |
| T5 | Editor DELETE own team asset | bob (Editor) | 200 Success | PASS |
| T6 | Editor POST new asset | bob (Editor) | 201 Created (Bravo) | PASS |
| T7 | Editor PUT other team asset | bob (Editor) | 403 Wrong team | PASS |
| T8 | GlobalAdmin GET /api/admin/logs | admin | Full log returned | PASS |
| T9 | Entra ID login — real Microsoft account | Karnage | JWT issued, GlobalAdmin | PASS |
| T10 | bcrypt local login | alice / pass123 | 200 Welcome alice | PASS |
| T11 | Rate limit brute force | alice / wrongpass x10 | 429 Too many attempts | PASS |
| T12 | Zod — empty asset creation | bob (Editor) | 400 Invalid input | PASS |
| T13 | Deny by default — unauthenticated route | None | 401 Not logged in | PASS |

---

## Production Notes

**Entra ID role mapping**
Roles are currently assigned based on username pattern matching in /auth/callback. A production deployment would use Entra ID App Roles or Group Claims to assign roles directly from the directory.

**Secure cookie**
secure: true is set automatically via NODE_ENV=production. Local development uses false since localhost does not support HTTPS.

**Audit log storage**
Logs are stored in SQLite which is appropriate for single-server deployments. At scale, replace with Azure Monitor, Datadog, or AWS CloudWatch.

**Automated tests**
Manual penetration testing was performed for all 13 cases. Adding a Jest + Supertest suite is the recommended next step.

---

## Running Locally

```bash
# Install dependencies
npm install

# Add your .env file with your credentials
# TENANT_ID, CLIENT_ID, CLIENT_SECRET, SESSION_SECRET, NODE_ENV

# Start the server
node server.js

# Visit
http://localhost:3000/frontend.html
```

---

## Tech Stack

| Package | Purpose |
|---------|---------|
| express | Web server |
| @azure/msal-node | Microsoft Entra ID OAuth2 |
| jsonwebtoken | JWT signing and verification |
| cookie-parser | HttpOnly cookie handling |
| bcrypt | Password hashing |
| better-sqlite3 | Persistent audit log and asset storage |
| helmet | HTTP security headers |
| express-rate-limit | Login brute force protection |
| zod | Request body validation |
| dotenv | Environment variable management |
