#!/usr/bin/env bash
# Run this from the root of the cloned esmk-mis repo, on the `dev` branch.
# Creates the Phase 1 folder skeleton with placeholder READMEs so empty
# folders survive being committed to git (git doesn't track empty dirs).
set -e

echo "Creating backend structure..."
mkdir -p backend/src/core/{auth,tenants,students,notifications,db}
mkdir -p backend/src/modules/pocket-money/{ledger,deposits,purchases,withdrawals,reversals,settlements,idempotency}
mkdir -p backend/src/api
mkdir -p backend/src/middleware
mkdir -p backend/tests

echo "Creating pos-app placeholder..."
mkdir -p pos-app

echo "Creating dashboard structure..."
mkdir -p dashboard/src/views/{balances,transactions,settlements}
mkdir -p dashboard/src/components

# --- Placeholder READMEs so folders aren't empty and explain their purpose ---

cat > backend/src/core/README.md << 'EOF'
# Core
Shared across every module, forever. Never put Pocket Money (or future
Attendance/Discipline/Events) logic in here.
EOF

cat > backend/src/core/auth/README.md << 'EOF'
Staff login, sessions, role checks (SRS NFR-5, RAB Section 5).
EOF

cat > backend/src/core/tenants/README.md << 'EOF'
School (tenant) setup and tenant-isolation middleware (SRS FR-8.1, ERD TENANT).
EOF

cat > backend/src/core/students/README.md << 'EOF'
Student registry and NFC card linking (SRS FR-1).
EOF

cat > backend/src/core/notifications/README.md << 'EOF'
Shared notification hooks — placeholder for future parent notifications.
EOF

cat > backend/src/core/db/README.md << 'EOF'
DB connection, migrations, base models.
EOF

cat > backend/src/modules/pocket-money/README.md << 'EOF'
# Pocket Money module
ALL Phase 1 money logic lives here. Nothing outside this folder (besides
core/) should touch balances or the ledger.
EOF

cat > backend/src/modules/pocket-money/ledger/README.md << 'EOF'
Append-only ledger — the single source of truth (SRS FR-2/3/4/5, NFR-2).
EOF

cat > backend/src/modules/pocket-money/deposits/README.md << 'EOF'
Bursar credit flow (SRS FR-2).
EOF

cat > backend/src/modules/pocket-money/purchases/README.md << 'EOF'
NFC tap purchase flow (SRS FR-3).
EOF

cat > backend/src/modules/pocket-money/withdrawals/README.md << 'EOF'
Cash withdrawal flow (SRS FR-4).
EOF

cat > backend/src/modules/pocket-money/reversals/README.md << 'EOF'
Correction/reversal entries (SRS FR-5).
EOF

cat > backend/src/modules/pocket-money/settlements/README.md << 'EOF'
Canteen/bursar reconciliation (SRS FR-6.3).
EOF

cat > backend/src/modules/pocket-money/idempotency/README.md << 'EOF'
Duplicate transaction-ID prevention (SRS FR-7).
EOF

cat > backend/src/api/README.md << 'EOF'
REST/WebSocket route definitions, grouped by module.
EOF

cat > backend/src/middleware/README.md << 'EOF'
Multi-tenant scoping, role-based access enforcement (SRS FR-8).
EOF

cat > backend/tests/README.md << 'EOF'
Backend tests, mirroring the src/ structure.
EOF

cat > pos-app/README.md << 'EOF'
Android NFC POS app. Separate runtime/language from backend — may move to
its own repo later. Flesh out once POS work starts (see docs/wireframes.md).
EOF

cat > dashboard/src/views/balances/README.md << 'EOF'
Live balance search view (SRS FR-6.2).
EOF

cat > dashboard/src/views/transactions/README.md << 'EOF'
Live transaction feed view (SRS FR-6.1).
EOF

cat > dashboard/src/views/settlements/README.md << 'EOF'
Settlement summaries + export view (SRS FR-6.3, FR-6.4).
EOF

cat > dashboard/src/components/README.md << 'EOF'
Shared dashboard UI components.
EOF

echo ""
echo "Done. Skeleton created. Now run:"
echo "  git add ."
echo "  git commit -m \"chore: scaffold Phase 1 folder skeleton\""
echo "  git push origin dev"
