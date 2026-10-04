# Contributing Workflow — ESMK MIS

Two-person team (Neverdie + Benit). Keep it lightweight but disciplined — this is real money logic, not a toy project.

## Branches

- `main` — always working, always deployable. Never push directly.
- `dev` — integration branch. All features merge here first.
- `feature/<short-name>` — one branch per task, e.g. `feature/deposit-flow`, `feature/nfc-tap-purchase`.

## Day-to-day flow

1. Pull latest `dev` before starting anything: `git checkout dev && git pull`
2. Branch off `dev`: `git checkout -b feature/your-task-name`
3. Commit in small, clear chunks: `git commit -m "feat(ledger): add deposit entry logging"`
4. Push your branch: `git push -u origin feature/your-task-name`
5. Open a Pull Request into `dev` on GitHub.
6. The other teammate reviews — even a quick pass — before merging.
7. Once a batch of features is stable in `dev`, merge `dev → main` and tag the release (e.g. `v1.0-phase1`).

## Commit message convention

`type(scope): short description`

Examples:
- `feat(deposits): implement bursar credit endpoint`
- `fix(ledger): prevent negative balance on withdrawal`
- `docs(readme): update setup instructions`

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

## Avoiding conflicts

- Before starting a task, check the shared board (GitHub Projects/Issues) and claim it so you're not both editing `ledger/` at the same time.
- Push and pull often — don't let a branch sit unsynced for days.
- Keep PRs scoped to one FR or one small piece of one FR — small PRs are easy to review and hard to conflict.

## Pull / Push cheat-sheet

```bash
# Start of every session
git checkout dev
git pull origin dev

# New task
git checkout -b feature/task-name

# While working
git add .
git commit -m "feat(scope): what you did"
git push -u origin feature/task-name   # first push
git push                                # subsequent pushes

# Getting teammate's latest dev into your branch (do this often to avoid big conflicts)
git checkout dev
git pull origin dev
git checkout feature/task-name
git merge dev

# When done — open PR on GitHub: feature/task-name → dev
```

## Branch protection (set once, on GitHub → Settings → Branches)

- Protect `main`: require PR + at least 1 approval before merge, no direct pushes.
- Optionally protect `dev` the same way once you're both comfortable with the flow.
