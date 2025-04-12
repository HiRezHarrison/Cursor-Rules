@echo off
git add .cursor/rules/global_rules
git commit -m "feat(rules): version 1.0 of global rules with improved documentation"
git tag -a v1.0 -m "Initial version 1.0 release of global rules"
git push origin main --tags 