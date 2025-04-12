# Versioning Rules for Cursor Projects
# Version: 1.0
# Last Updated: [Current Date]

## Overview
This document defines the versioning rules and practices for Cursor projects. These rules are designed to ensure consistent versioning across all projects and to maintain a clear history of changes.

## Version Number Format
- Use Semantic Versioning (SemVer) format: MAJOR.MINOR.PATCH
  - MAJOR: Breaking changes
  - MINOR: New features (backwards compatible)
  - PATCH: Bug fixes (backwards compatible)

## Versioning Process
1. All significant changes must be versioned
2. Version numbers must be incremented according to the impact of changes
3. Each version must be tagged in Git
4. Version changes must be documented in the relevant files

## Required Files
The following files must contain version information:
- `.cursor/rules/global_rules.md`: Contains the main rules and guidelines
- `.cursor/rules/versioning_rules.md`: This file, containing versioning-specific rules
- Any other rule files in the `.cursor/rules` directory

## Version Update Process
1. Update version numbers in all relevant files
2. Create a Git tag for the new version
3. Push changes and tags to the remote repository
4. Document the changes in the project's notes

## Version History
- v1.0: Initial release of versioning rules
  - Established versioning format
  - Defined versioning process
  - Specified required files
  - Created version update process

## Related Documents
- See `.cursor/rules/global_rules.md` for general project rules and guidelines
- See `.cursor/notes/project_checklist.md` for version update checklist
- See `.cursor/notes/notebook.md` for version history and notes 