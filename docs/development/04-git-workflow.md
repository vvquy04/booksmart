# Git Workflow & Commit Conventions

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Collaboration Workflow

All changes to the codebase are managed through Git.

```
          [ Local Feature Branch: feature/booking-validation ]
                                  │
                                  ▼
                     [ Push to Remote Repository ]
                                  │
                                  ▼
                      [ Open Pull Request (PR) ]
                                  │
                                  ▼
                   [ Code Review & CI Test Run ]
                                  │
                                  ▼
                [ Merge to integration branch: develop ]
```

---

# 2. Commit Message Conventions

We enforce the **Conventional Commits** specification. Commit messages must match the pattern:

```
<type>(<scope>): <subject>

[optional body]

[optional footer(s)]
```

### Supported Message Types
*   **`feat`**: A new feature (e.g. `feat(booking): implement timeslot lock check`).
*   **`fix`**: A bug fix (e.g. `fix(auth): resolve refresh token expiration check`).
*   **`docs`**: Documentation changes (e.g. `docs(api): document payment webhooks`).
*   **`style`**: Formatting, white-space, semicolon additions (no code changes).
*   **`refactor`**: Code restructuring that neither fixes a bug nor adds a feature.
*   **`test`**: Adding missing tests or refactoring test suites.
*   **`chore`**: Maintenance, build tool setups, dependency updates (e.g. `chore(pom): upgrade spring boot version`).

### Commit Formatting Rules
*   Use imperative mood ("add" not "added", "fix" not "fixed").
*   Subject line must not exceed 72 characters.
*   Separate subject line from body with a blank line.

---

# 3. Pull Request Protocol

1.  **Creation**: Always create a feature branch off the `develop` branch (e.g. `feature/auth-jwt`).
2.  **Self Review**: Before requesting feedback, review your own diff for debugging artifacts (e.g. `System.out.println`, leftover TODOs).
3.  **CI Validation**: All automated tests must compile and pass successfully on Github Actions before merging.
4.  **Approvals**: A minimum of 1 peer code review approval is required before a Pull Request can be merged into `develop`.
5.  **Merging Mode**: Use **Squash and Merge** to maintain a clean history on integration branches.
