# Git Branching Strategy

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Branch Hierarchy

BookSmart follows the **Gitflow** branching model. The repository keeps two persistent branches (`main` and `develop`) alongside temporary helper branches.

```
  main (Production)
   │
   ├─► hotfix/1.0.1 ──────────────────────┐
   │                                      │
   ├─► release/1.1.0 ◄───┐                │
   │                     │                │
  develop (Integration)  │                │
   │                     ├─► develop      ├─► main & develop
   ├─► feature/booking ──┘                │
   ├─► feature/payment ───────────────────┘
```

### Persistent Branches
*   **`main`**: The official production branch. Contains only stable, tested release tags. Direct commits are strictly prohibited.
*   **`develop`**: The primary integration branch. All developers merge their feature branches here. It serves as the baseline for staging tests.

---

# 2. Supporting Branches

### Feature Branches (`feature/*`)
*   **Purpose**: Used to develop new features or major refactorings.
*   **Source Branch**: `develop`.
*   **Merge Target**: `develop`.
*   **Naming**: `feature/<module>-<short-description>` (e.g. `feature/booking-calendar`).

### Release Branches (`release/*`)
*   **Purpose**: Prepare code for production release. Permits final bug fixes and documentation polish without blocking feature development.
*   **Source Branch**: `develop`.
*   **Merge Target**: `main` (for release tags) and `develop` (to port back any release-prep bug fixes).
*   **Naming**: `release/<version-number>` (e.g. `release/1.0.0`).

### Hotfix Branches (`hotfix/*`)
*   **Purpose**: Quick patches to resolve critical production bugs immediately.
*   **Source Branch**: `main`.
*   **Merge Target**: `main` (and merged back into `develop`).
*   **Naming**: `hotfix/<version-number>` (e.g. `hotfix/1.0.1`).
