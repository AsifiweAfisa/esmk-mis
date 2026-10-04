# UI/UX — Phase 1 Page Inventory & Wireframes

Source: UI/UX Page Inventory & Wireframes v1.0 (Sept 16, 2026), companion to SRS v1.1, PRD v1.0, SAD v1.0, ERD v1.0, RAB v1.0.

Wireframes are deliberately low-fidelity (boxes, placeholder text, no color/branding) — the goal at this stage is agreeing what information appears where and what a user can do, before spending time on visual polish. Mockups (styled, on-brand) and a clickable prototype come after this set is agreed, not before.

## Full page inventory (12 screens)

| Screen | Used by | Purpose | Requirement |
|---|---|---|---|
| Staff Login | All staff roles | Authenticate before any action is allowed | NFR-5 |
| POS: Tap to Pay (idle) | Canteen Staff | Wait for a card tap, show amount to charge | FR-3.1 |
| POS: Approved result | Canteen Staff | Confirm a successful purchase and new balance | FR-3.5, FR-3.6 |
| POS: Rejected result | Canteen Staff | Show why a tap failed (balance/connection) | FR-3.3, FR-3.4, NFR-4 |
| Bursar Console: Find Student | Bursar | Look up a student before acting on their account | FR-2.1, FR-4.1 |
| Bursar Console: Record Transaction | Bursar | Deposit or withdraw for the found student | FR-2, FR-4 |
| Bursar Console: Student History | Bursar | View that student's full ledger | FR-6.2 |
| Card Management | Bursar, Admin | Issue a new card, deactivate a lost one | FR-1.2, FR-1.3 |
| Admin Dashboard: Overview | Director/Admin, Bursar | Live summary + live transaction feed, school-wide | FR-6.1, FR-6.2 |
| Admin Dashboard: Settlement | Director/Admin, Bursar | Reconcile canteen sales against bursar records | FR-6.3 |
| Admin: Reports Export | Director/Admin, Bursar | Download transaction/settlement reports | FR-6.4 |
| Admin: Staff Accounts | Director/Admin | Create/deactivate staff logins, assign roles | RAB Section 3 |
| Platform Admin: School Onboarding | Ubaka Tech Platform Admin | Set up a new school tenant and its first admin | FR-8.3 |

## Wireframed now (3 highest-priority screens)

Wireframed first because they're the highest-traffic, highest-risk screens — used constantly (POS), handling money directly (Bursar Console), and the primary trust-building tool for the school (Admin Dashboard). The remaining 9 screens follow the same visual language and get wireframed in the same pass before development begins.

### 1. POS Tap-to-Pay flow (3 states: idle, approved, rejected)

The simplest possible flow by design — NFR-9 requires canteen staff to learn this in under 15 minutes, so every unnecessary tap, button, or decision here is a design mistake, not a minor detail.

- Idle state shows the amount and outlet clearly before any tap, so staff confirm the price is right before the student taps.
- Approved and Rejected are visually distinct at a glance (green vs. red) — a busy lunch queue needs an answer readable in under a second.
- Rejected always states a reason (FR-3.3/FR-3.4) — "insufficient balance" and "no connection" need different staff responses, never a generic failure message.

### 2. Bursar Console

The bursar's primary workspace: find a student, see balance and card status at a glance, record a deposit or withdrawal, see recent history without leaving the page.

- Deposit and Withdraw are visually separated (green/red) to reduce the chance of selecting the wrong action under time pressure.
- Card status (Active/Blocked) shown directly on the student card, since card issues (FR-1.3) are handled from this same screen.
- A permanent UI reminder of FR-5.1 (no entry can be edited, only corrected with a new linked entry) is shown at the bottom — this constraint is visible to the user, not just enforced silently.

### 3. Admin Dashboard

The director's and bursar's shared view of the whole school's activity. Everything on this screen updates live, no manual refresh (FR-6).

- Summary cards at the top answer "how much money is in the system right now" at a glance.
- The live feed (FR-6.1) is explicitly labeled "LIVE" so users understand new rows appear on their own — an easy point of confusion if left unlabeled.
- The settlement panel satisfies FR-6.3 — matching system totals against the bursar's physical count, with a clear MATCHED/MISMATCHED signal.

## What comes next

1. Agreement on this wireframe set between you and Benit, and ideally a quick walkthrough with ESMK's actual bursar and a canteen staff member — the people who'll use these daily.
2. Wireframe the remaining 9 screens in the same pass, same visual language.
3. **Mockups** — the same layouts, restyled with an actual color scheme, logo, and typography.
4. A **clickable prototype** connecting the screens together, to validate the flow before writing production code.

## Turning the agreed wireframes into styled mockups

Once the wireframe set above is signed off, these prompts turn the three agreed layouts into a first-pass styled mockup (one screen/flow per prompt — paste individually) in a tool like Google Stitch. Treat the output as a starting point to react to, not a final design:

**POS app (5 states in one flow):**
```
Design a minimal Android POS app screen for a school NFC pocket-money system. Show 5 states: (1) idle screen displaying the outlet name and amount to charge, (2) fetching balance with a spinner, (3) approved confirmation in green showing student name, amount, and new balance, (4) rejected state in red for insufficient balance, (5) rejected state in red for no connection — each rejection states its specific reason. Extremely simple, large touch targets; canteen staff learn it in under 15 minutes. No offline mode.
```

**Bursar Console:**
```
Design a web screen for a school bursar managing student pocket-money balances. Include: a student search/find view, a student detail view showing current balance, card status (Active/Blocked), and recent transaction history, plus two clearly separated actions — Deposit (green) and Withdraw (red). Include a small persistent note that no transaction can be edited, only corrected with a new linked entry. Clean, functional, form-based.
```

**Admin Dashboard:**
```
Design a web admin dashboard for a school pocket-money platform. Include: summary cards at the top (total balances, today's transaction volume), a "LIVE" labeled transaction feed that updates without refresh, and a settlement panel comparing canteen sales against bursar records with a clear MATCHED/MISMATCHED indicator. Should feel trustworthy and clear to a non-technical school director.
```
