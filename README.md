# ESMK MIS — School NFC Pocket Money & Visibility Platform

**Company:** Ubaka Tech Ltd
**Client:** Ecole Secondaire Sancta Maria de Karambo (ESMK), Gicumbi District, Rwanda
**Phase:** 1 — Pocket Money Module
**Status:** 🚧 In Development
**System Ref:** 3F7B1C59
**Docs:** SRS v1.1 · PRD v1.0 · SAD v1.0 · RAB v1.0 · ERD v1.0 · UI/UX v1.0 (all Sept 16, 2026)

## 📖 Overview

ESMK is a boarding secondary school (O-Level/A-Level) with no MIS outside of NESA's CAMIS for academics. Students currently carry physical cash for pocket money, which creates loss/theft risk, slow canteen queues, and zero visibility for the school when a dispute comes up.

ESMK MIS replaces that with an NFC card system: each student's money lives on the platform, every transaction is recorded the instant it happens, and school staff get a live view of balances, purchases, and settlements. This product is intentionally scoped to complement CAMIS, not duplicate or integrate with it — this is the money and daily-operations side of school life, not academics.

**Phase 1** covers the core Pocket Money module only:
- Bursar credits a student's balance (cash/mobile money handed over outside the system)
- Canteen staff deduct balance via NFC tap on a POS device, one outlet to start
- Bursar processes cash withdrawals
- Real-time dashboard for school admins
- Multi-tenant support (multiple schools, fully isolated) — ESMK is the first, not the only
- Modular design so future features (Attendance, Discipline, Events) don't touch the money logic

**Not in scope for Phase 1:** parent-facing app / direct parent top-ups (Phase 2), any integration with CAMIS or government systems.

## 🏗️ Architecture Principles

Non-negotiable design constraints — keep them in mind on every PR:

- **No offline approval, ever.** If a POS device can't reach the server, the transaction is rejected outright. No caching, no queuing.
- **Append-only ledger.** No ledger entry is ever edited or deleted. Corrections are new, linked reversing entries (`reverses_entry_id`).
- **Balance is derived, not stored.** A student's balance is always the sum of their ledger entries — never a mutable column that can drift out of sync.
- **Multi-tenant from day one.** Every tenant-owned table carries `tenant_id`; one school's data must never be visible to another.
- **Atomic balance operations.** Balance checks + deductions happen as a single atomic DB operation (row-level locking) to prevent double-spend on simultaneous taps.
- **Idempotent transactions.** Every POS transaction carries a client-generated unique `idempotency_key`; duplicates are ignored, not double-charged.
- **Permissions enforced server-side, always.** Hiding a button in the UI is not access control — every request is checked against the role matrix at the API layer, independent of what the client sends.
- **Works without the internet.** The system runs on the school's local network, not the public internet — see Deployment below.

## 🧱 Tech Stack & Deployment

| Layer | Choice |
|---|---|
| Backend | Node.js |
| Database | PostgreSQL (strong transactional guarantees for money) |
| POS App | Android, NFC-enabled |
| Dashboard | Browser-based, responsive web app |
| Hosting (Phase 1) | **Single on-site server at the school, on the school's local network** — not cloud. POS app and dashboard connect over WiFi/LAN, not the public internet, so the system keeps working even if the school's internet connection is down. |
| Backups | Automated daily, retained 30+ days, stored on separate physical media from the primary server |

> **Note on hosting:** the original SRS draft described cloud hosting (AWS/DigitalOcean). The team has settled on the SAD's on-site/local-network model for Phase 1 — lower cost, no internet dependency for daily operation. Moving to cloud hosting (e.g. ahead of a Phase 2 parent portal) is a deployment/configuration change later, on agreed terms, not an application redesign.

## 👥 Roles & Permissions

| Role | Description | Access (full detail in `docs/RAB.md`) |
|---|---|---|
| Director / Admin | Owns the school's account, sees everything, configures settings, pulls reports | Full read/write, including staff account management |
| Bursar | Credits balances, processes withdrawals, resolves disputes | Full read/write on ledger (near-identical to Admin by design — ESMK is small enough the Director may act as bursar) |
| Canteen Staff | Runs NFC tap purchases for their own outlet | POS app only; sees a live balance only during an active tap, and same-day settlement for their own outlet only |
| Student | Carries NFC card only | None — card-only, no login |
| Ubaka Tech Platform Admin | Onboards new schools | Platform-level only — zero visibility into any school's financial data |

Every permission is enforced server-side, never only hidden in the UI (RAB Section 5).

## 📂 Project Structure

See [`docs/module-structure.md`](docs/module-structure.md) for the full folder layout and module boundaries.

## 📊 Data Model

See [`docs/ERD.md`](docs/ERD.md) — entities are Tenant, User, Student, Card, Outlet, and Ledger_Entry (the single source of truth for all money movement).

## 🎨 UI/UX

See [`docs/wireframes.md`](docs/wireframes.md) for the full 12-screen Phase 1 page inventory and the three wireframed priority screens (POS Tap-to-Pay, Bursar Console, Admin Dashboard).

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/<org-or-user>/esmk-mis.git
cd esmk-mis

# Install dependencies (once package.json exists)
npm install

# Set up environment variables
cp .env.example .env

# Run database migrations
npm run migrate

# Start dev server
npm run dev
```

## 🌳 Branching & Workflow

- `main` — always stable/deployable, protected (PR + 1 approval required)
- `dev` — integration branch, all features merge here first
- `feature/<name>` — one branch per feature, branched off `dev`

All changes land via Pull Request into `dev`, reviewed by the other teammate before merge. See [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) for the full workflow.

## 👤 Team

| Role | Contact |
|---|---|
| Author | benit@ubakatech.co.rw |
| Revised by | asifiwe@ubakatech.co.rw |

## 📄 Docs

- `docs/SRS-v1.1.pdf` — behavior/requirements
- `docs/PRD-v1.0.pdf` — goals/scope, client, success metrics
- `docs/SAD-v1.0.pdf` — system architecture, components, deployment
- `docs/RAB-v1.0.pdf` — full roles & permissions matrix
- `docs/ERD.md` — data model
- `docs/wireframes.md` — page inventory + wireframes
- `docs/CONTRIBUTING.md` — git workflow
