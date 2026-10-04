# Module Structure — Phase 1

The system is split into a **common core** (shared by every module, now and in future phases) and **feature modules** (Pocket Money now, Attendance/Discipline/Events later). Nothing outside `pocket-money/` should contain money logic — that's the whole point of the modular constraint in the SRS (NFR-8).

```
esmk-mis/
├── backend/
│   ├── src/
│   │   ├── core/                      # Shared across all modules — never touched per-feature
│   │   │   ├── auth/                  # Staff login, sessions, role checks
│   │   │   ├── tenants/               # School (tenant) setup, isolation middleware
│   │   │   ├── students/              # Student registry, NFC card linking (FR-1)
│   │   │   ├── notifications/         # Shared notification hooks (future parent notifications)
│   │   │   └── db/                    # DB connection, migrations, base models
│   │   │
│   │   ├── modules/
│   │   │   └── pocket-money/          # ALL Phase 1 money logic lives here
│   │   │       ├── ledger/            # Append-only ledger (FR-2, FR-3, FR-4, FR-5)
│   │   │       ├── deposits/          # Bursar credit flow (FR-2)
│   │   │       ├── purchases/         # NFC tap purchase flow (FR-3)
│   │   │       ├── withdrawals/       # Cash withdrawal flow (FR-4)
│   │   │       ├── reversals/         # Correction/reversal entries (FR-5)
│   │   │       ├── settlements/       # Canteen/bursar reconciliation (FR-6.3)
│   │   │       └── idempotency/       # Duplicate transaction-ID prevention (FR-7)
│   │   │
│   │   ├── api/                       # REST/WebSocket route definitions, grouped by module
│   │   ├── middleware/                # Multi-tenant scoping, role-based access (FR-8)
│   │   └── app.js                     # Entry point
│   │
│   ├── tests/
│   └── package.json
│
├── pos-app/                           # Android NFC POS app (separate project/repo submodule if needed)
│   └── README.md                      # Placeholder — flesh out when POS work starts
│
├── dashboard/                         # Web dashboard (FR-6)
│   ├── src/
│   │   ├── views/
│   │   │   ├── balances/              # Live balance search (FR-6.2)
│   │   │   ├── transactions/          # Live transaction feed (FR-6.1)
│   │   │   └── settlements/           # Settlement summaries + export (FR-6.3, FR-6.4)
│   │   └── components/
│   └── package.json
│
├── docs/
│   ├── SRS-Phase1.pdf
│   ├── module-structure.md            # this file
│   └── CONTRIBUTING.md
│
├── .gitignore
├── .env.example
└── README.md
```

## Why this shape

- **`core/` vs `modules/pocket-money/`** — this is the line the SRS draws (NFR-8): identity, tenant setup, and auth are shared forever; money logic is isolated so Attendance/Discipline/Events (Phase 2+) can be added as sibling folders under `modules/` without ever importing from or editing `pocket-money/`.
- **`ledger/` is the source of truth** — per NFR-2, displayed balances are always derived from the ledger, never stored independently. Keep balance-read logic inside `ledger/`, not duplicated in `deposits/` or `purchases/`.
- **`pos-app/` is separate from `backend/`** — different language/runtime (Android), so it can even live in its own repo later if that's cleaner; a placeholder folder keeps it visible in planning for now.
