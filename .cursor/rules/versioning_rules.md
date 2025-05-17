# Versioning Rules for Cursor Projects
# Version: 1.2
# Last Updated: May 17, 2025

## Overview
This document defines the versioning rules and practices for Cursor projects. These rules are designed to ensure consistent versioning across all projects and to maintain a clear history of changes.

## Trigger Commands

This section outlines commands to help automate common version control and release tasks. Here's a typical workflow:

1.  **Ongoing Development:** Use the **`'Sync Changes'`** command frequently to commit and push your work to the current development branch (e.g., `main`). This keeps your work saved and synchronized.
2.  **Preparing for a Release:**
    *   When ready to create a new versioned release (e.g., for stabilization or distribution), you might first use the **`'Create Release Branch'`** command to create a dedicated branch (e.g., `release/v1.2.0`) from your development branch. This isolates the release preparation. Switch to this new branch.
    *   On the release branch, perform any final checks or minor fixes, using `'Sync Changes'` for these.
    *   Once satisfied, use the **`'Prepare Release'`** command. This will guide you through determining the correct semantic version (MAJOR, MINOR, PATCH), update version numbers in specified files, update version history, commit these versioning changes, and create a Git tag (e.g., `v1.2.0`).
3.  **Finalizing the Release:** After `'Prepare Release'` has successfully run and created the version commit and tag, use the **`'Sync Changes'`** command one last time. This will push the version commit *and* the new Git tag to the remote repository, making the release official.
4.  **Post-Release (Optional):** Merge the release branch (e.g., `release/v1.2.0`) back into your main development branch if any fixes were made on it. Then, continue development on the main branch for the next cycle.

These commands aim to provide a balance of automation and user control for a structured development and release process.

### 'Sync Changes' Trigger Command
When the user issues the "Commit and Push" command, or a similar directive to save and synchronize changes, the agent should perform the following steps autonomously:

1.  **Confirm Intent & Obtain Commit Message:**
    *   Acknowledge the command.
    *   If a specific commit message was not provided alongside the command or is not clearly inferable from the immediate preceding conversation, prompt the user: "Understood. What should the commit message be for these changes? Please use conventional commit format (e.g., `feat(module): description`)."
    *   If the user provides a message, use it. If the agent is to proceed without a specific user message (e.g., user says "just use a generic one for now"), use a message like `chore: synchronize changes` or `checkpoint: automatic save point`. However, always prefer a user-provided message.

2.  **Stage Changes:**
    *   Execute `git add .` to stage all current changes in the workspace.
    *   Report briefly on the action (e.g., "Staging all changes.").

3.  **Commit Changes:**
    *   Execute `git commit -m "<commit_message>"` using the obtained or generated commit message.
    *   Report briefly on the action (e.g., "Committing changes with message: '<commit_message>'").
    *   Handle potential errors (e.g., nothing to commit) gracefully. If nothing to commit, inform the user and skip to step 5 if no push is needed.

4.  **Push Changes:**
    *   Execute `git push` to synchronize the local commits with the remote repository.
    *   Report briefly on the action (e.g., "Pushing changes to the remote repository.").
    *   Handle potential errors (e.g., push conflicts, authentication issues). If a conflict occurs that the agent cannot automatically resolve (e.g., requires a merge), inform the user clearly about the conflict and await further instructions. For simple retryable errors, the agent may attempt a retry once.

5.  **Verify Status:**
    *   Execute `git status` to confirm the working tree is clean and the branch is up-to-date with the remote.
    *   Report the status to the user (e.g., "Verification complete. `git status` output: [output]. The repository is synchronized and the working tree is clean.").
    *   If `git status` indicates further actions are needed (e.g., branch is ahead but not yet pushed fully, or unexpected untracked files), report this clearly.

6.  **Autonomy and Error Handling:**
    *   The agent should aim to complete these steps with minimal user intervention.
    *   If errors occur (e.g., git command failures, network issues), the agent should attempt to diagnose and resolve them if possible (e.g., simple retries for network glitches).
    *   If an error cannot be resolved autonomously (e.g., merge conflicts, persistent authentication failures), the agent must clearly report the problem, the steps taken, and what is needed from the user.
    *   The goal is to automate routine commits and pushes, not to replace human judgment for complex SCM scenarios.

### "Prepare Release" Trigger Command
When the user issues the "Prepare Release" command, the agent should:

1.  **Determine Version Increment Type:**
    *   The agent identifies the most recent Git tag (e.g., `vX.Y.Z`). If no tags are found, it assumes an initial version (e.g., `0.1.0` if starting fresh, or asks the user for a starting point).
    *   It retrieves and analyzes commit messages (looking for Conventional Commit types like `feat`, `fix`, and `BREAKING CHANGE:` indicators in the message body/footer) since that last tag (or from the beginning if no tags).
    *   The agent presents a summary of its findings (e.g., "Since tag vX.Y.Z, I found: 3 'fix' commits, 1 'feat' commit, and no explicit 'BREAKING CHANGE:' markers.")
    *   Based on this, the agent suggests an increment type: "Based on this, I recommend this be a [MAJOR/MINOR/PATCH] release."
    *   The agent asks the user: "Do you agree with this suggestion, or would you like to specify a different increment type (MAJOR, MINOR, PATCH)?"
    *   The agent proceeds with the user-confirmed or user-specified increment type.

2.  **Identify Files to Version:**
    *   The agent refers to the "Required Files" section within this `versioning_rules.md` document to identify standard files that require version number updates.
    *   The agent asks the user: "Are there any other project-specific files that need their version numbers updated for this release (e.g., `package.json`, `setup.py`, a `README.md` version badge)?"

3.  **Calculate and Update Version Numbers:**
    *   Based on the current version found in the primary versioned file (e.g., `versioning_rules.md` itself, or a project manifest) and the confirmed increment type, calculate the new version (e.g., `1.1.0` + MINOR -> `1.2.0`).
    *   For each file identified in step 2, the agent proposes changes to update the version number string and any "Last Updated" dates.
    *   The agent should seek user confirmation before applying these file changes if multiple files or complex updates are involved.

4.  **Update Version History/Changelog:**
    *   In files that maintain a "Version History" section (like `versioning_rules.md`), the agent proposes adding an entry for the new version. The user should be prompted for a brief description of key changes for this version to include in the history.
    *   (If applicable to the project, e.g., software): If a `CHANGELOG.md` exists, the agent proposes appending new version details, potentially summarizing from conventional commit messages since the last tag.

5.  **Stage and Commit Version Changes:**
    *   After all file modifications are confirmed and applied, the agent stages *only* the files that were modified for versioning.
    *   The agent proposes a standardized commit message, e.g., `chore(release): bump version to vX.Y.Z`, and asks for user confirmation.

6.  **Create Git Tag:**
    *   Using the new version number (e.g., `vX.Y.Z`), the agent proposes creating an annotated Git tag: `git tag -a vX.Y.Z -m "Version X.Y.Z"`.
    *   The agent asks for user confirmation before creating the tag.

7.  **Report and Next Steps:**
    *   The agent informs the user: "Release vX.Y.Z has been prepared. Version numbers updated, changes committed with message 'chore(release): bump version to vX.Y.Z', and tag 'vX.Y.Z' created. Ready to use the 'Sync Changes' command to push this commit and tag to the remote repository?"

### "Create Release Branch" Trigger Command
When the user issues the "Create Release Branch" command:

1.  **Determine Base Branch:**
    *   The agent determines the current branch (e.g., `git rev-parse --abbrev-ref HEAD`).
    *   It asks the user: "The current branch is '[current_branch_name]'. Should this be the base for the new release branch? (Yes/No/Specify other branch)"
    *   The agent proceeds with the user-confirmed or specified base branch.

2.  **Determine New Release Branch Name:**
    *   The agent asks the user for the intended version of this release (e.g., "What version is this release branch for, like '1.2.0'?").
    *   It suggests a branch name based on the version, e.g., `release/v1.2.0`.
    *   The user confirms or provides an alternative name.

3.  **Create and Optionally Switch to New Branch:**
    *   The agent executes `git checkout -b <new_release_branch_name> <base_branch_name>`.
    *   It asks the user: "New branch '<new_release_branch_name>' has been created from '<base_branch_name>'. Do you want to switch to this new branch for further work on this release? (Yes/No)"
    *   If yes, the agent confirms it is now operating on the new release branch.
    *   If no, the agent ensures it returns to the original base branch (e.g., `git checkout <base_branch_name>`).

4.  **Optionally Push New Branch:**
    *   The agent asks the user: "Do you want to push the new branch '<new_release_branch_name>' to the remote repository now? This makes it available for collaboration or remote builds."
    *   If yes, the agent executes `git push -u origin <new_release_branch_name>`.

5.  **Report:**
    *   The agent summarizes the actions taken: which branch was created, from what base, whether the agent switched to it, and whether it was pushed to the remote.

## Versioning Processes
### Version Number Format
- Use Semantic Versioning (SemVer) format: MAJOR.MINOR.PATCH
  - MAJOR: Breaking changes
  - MINOR: New features (backwards compatible)
  - PATCH: Bug fixes (backwards compatible)

### Versioning Process
1. All significant changes must be versioned
2. Version numbers must be incremented according to the impact of changes
3. Each version must be tagged in Git
4. Version changes must be documented in the relevant files

### Required Files
The following files must contain version information:
- `.cursor/rules/global_rules.md`: Contains the main rules and guidelines
- `.cursor/rules/versioning_rules.md`: This file, containing versioning-specific rules
- Any other rule files in the `.cursor/rules` directory

### Version Update Process
1. Update version numbers in all relevant files
2. Create a Git tag for the new version
3. Push changes and tags to the remote repository
4. Document the changes in the project's notes

### Commit Message Formatting
To ensure a clear and consistent commit history, all commit messages should adhere to the **Conventional Commits** specification (v1.0.0). This format makes it easier to understand changes at a glance and supports automated changelog generation.

The basic format is:
`type(scope): subject`

-   **type**: Describes the kind of change. Common types include:
    -   `feat`: A new feature
    -   `fix`: A bug fix
    -   `docs`: Documentation only changes
    -   `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
    -   `refactor`: A code change that neither fixes a bug nor adds a feature
    -   `perf`: A code change that improves performance
    -   `test`: Adding missing tests or correcting existing tests
    -   `chore`: Changes to the build process or auxiliary tools and libraries such as documentation generation
    -   `ci`: Changes to CI configuration files and scripts
    -   `build`: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
-   **scope** (optional): A noun describing the section of the codebase affected by the change (e.g., `auth`, `api`, `parser`, `rules`).
-   **subject**: A concise description of the change.
    -   Use the imperative, present tense: "change" not "changed" nor "changes".
    -   Don't capitalize the first letter.
    -   No dot (.) at the end.

**Example:**
`feat(auth): implement social login via Google`
`fix(parser): correct handling of malformed input string`
`docs(readme): update setup instructions`
`chore: update npm dependencies`

A longer commit body MAY be provided after the subject, separated by a blank line. A footer MAY also be provided.
Refer to [https://www.conventionalcommits.org/](https://www.conventionalcommits.org/) for the full specification. 

## Version History
- v1.2: Added 'Prepare Release' & 'Create Release Branch' commands; added workflow summary to Trigger Commands.
- v1.1: Added "Version Control" trigger command
- v1.0: Initial release of versioning rules
  - Established versioning format
  - Defined versioning process
  - Specified required files
  - Created version update process

## Related Documents
- See `.cursor/rules/global_rules.md` for general project rules and guidelines
- See `.cursor/notes/project_checklist.md` for version update checklist
- See `.cursor/notes/notebook.md` for version history and notes
