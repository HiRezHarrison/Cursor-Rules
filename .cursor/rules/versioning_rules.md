# Versioning and Branching Strategy

This document outlines the versioning and branching strategy to be followed for projects using this ruleset. The goal is to ensure consistent, traceable, and automated (where possible) version control practices.

## 1. Semantic Versioning (SemVer)

We will strictly adhere to Semantic Versioning 2.0.0 (MAJOR.MINOR.PATCH).

- **MAJOR**: Incremented for incompatible API changes or significant shifts in functionality/scope. MAJOR version bumps should generally be user-defined, but the AI may suggest one if a large volume of changes significantly alters the project scope compared to the previous MAJOR version.
- **MINOR**: Incremented for new features or distinct chunks of work added in a backward-compatible manner. Each logical chunk of work outlined in the project scope document (e.g., in `project_checklist.md` or a dedicated tech spec) corresponds to a MINOR version increment.
- **PATCH**: Incremented for backward-compatible bug fixes. A PATCH release addresses issues within a specific MINOR version.

**Release Flow:**
- Bug fixes (PATCH) for a given MINOR version (e.g., `v1.3.x`) are released *before* work begins on the next MINOR version (e.g., `v1.4.0`).
- Example: If `v1.3.1` is released and a bug requires `v1.3.2`, the `v1.3.2` fix is completed and released. Only then does development start for `v1.4.0`.

## 2. Branching Model (Gitflow-Inspired)

We will use a simplified Gitflow model:

- **`main`**: This branch represents the latest stable, production-ready MAJOR release. Only tagged releases and hotfixes should be merged directly into `main`. Direct commits to `main` are forbidden.
- **`develop`**: This is the primary integration branch for ongoing development. It reflects the latest delivered development changes for the next release (MINOR or MAJOR). All completed `feature/*` branches and `hotfix/*` branches are merged into `develop`.
- **`feature/<scope-task-or-version>`**: Used for developing new features or specific work chunks corresponding to a MINOR version.
    - Branched *from* `develop`.
    - Merged *back into* `develop` upon completion.
    - Naming examples: `feature/user-auth-v0.2`, `feature/api-endpoint-v1.3`.
- **`hotfix/<version>`**: Used for critical bug fixes discovered in a tagged release (`main`).
    - Branched *from* the relevant tag on `main` (e.g., `v1.1.0`).
    - Merged *back into* both `main` AND `develop` upon completion.
    - Naming example: `hotfix/v1.1.1`.

## 3. Automation and AI Responsibilities

The AI agent is responsible for managing branches and versions according to these rules:

- **Branch Creation:** Automatically create `feature/*` branches when starting a new MINOR work chunk defined in the project scope. Automatically create `hotfix/*` branches when a bug fix for a release is required.
- **Version Bumping:** Automatically determine the next version number based on the type of work (feature -> MINOR bump, bug fix -> PATCH bump). MAJOR bumps require user confirmation.
- **State Tracking:** Consistently update the *current project version* and *active development branch* in `.cursor/notes/agentnotes.md` at the start of work and after any version change or branch switch.

## 4. Committing and Tagging

- **Commit Trigger:** Commits should be made after a logical piece of work (feature, task, bug fix) is completed, *all* relevant tests (unit, integration, feature) have passed, and all required documentation (`agentnotes.md`, `notebook.md`, `project_checklist.md`) has been updated.
- **Staging Files:** Before committing, stage all changed/new files relevant to the commit individually using `git add <file_path>` for each file. Do not attempt to stage entire directories or multiple files with a single `add` command.
- **Commit Messages:** Use the Conventional Commits format, referencing the scope/task from the project plan.
    - Format: `type(scope): description (vX.Y.Z) - scope: <Project Plan Task/Bug ID>`
    - Examples:
        - `feat(auth): implement password reset endpoint (v0.2.0) - scope: Task 3`
        - `fix(ui): resolve button alignment issue (v1.1.1) - scope: Bug #42`
        - `docs(readme): update installation instructions (v1.2.0) - scope: Task 5`
- **Tagging:** Create an annotated Git tag for *every* completed version (MAJOR, MINOR, PATCH) immediately after the corresponding merge to a stable branch (`main` or `develop`).
    - Command: `git tag -a vX.Y.Z -m "Release version X.Y.Z"`
    - Tags for PATCH releases (hotfixes) are made on `main`.
    - Tags for MINOR/MAJOR releases can initially be made on `develop` upon feature completion, and definitely on `main` upon merging `develop` for a MAJOR release.

## 5. Merging Strategy

- `feature/*` -> `develop`: Merge feature branches into `develop` only when the feature is complete, tested, documented, and reviewed (self-review minimum). Use `--no-ff` (no fast-forward) merges to preserve feature branch history.
- `hotfix/*` -> `main` & `develop`: Merge hotfix branches into `main` first, then tag the release on `main`. Immediately afterwards, merge the same hotfix branch into `develop` to ensure the fix is incorporated into ongoing development. Use `--no-ff` merges.
- `develop` -> `main`: Merge `develop` into `main` only when preparing for a new MAJOR release. This merge signifies a stable, production-ready state. Tag the release on `main` immediately after the merge. Use `--no-ff` merges.

## 6. Initial Project Setup

- The project typically starts at version `v0.1.0`.
- The initial work happens on the `develop` branch, possibly branching off immediately to a `feature/*` branch for the first work chunk.
- The `main` branch is created initially but only receives merges from `develop` (for MAJOR releases) or `hotfix/*` branches.

## 7. Pre-Commit/Pre-Merge Checks

- Before any commit intended for merging (feature completion, hotfix), ensure:
    - All relevant unit, integration, and feature tests pass.
    - Code adheres to any project-specific linting or style guides.
    - Documentation (`agentnotes.md`, `notebook.md`, `project_checklist.md`, code comments) is up-to-date. 