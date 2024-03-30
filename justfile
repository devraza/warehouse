#!/usr/bin/env just --justfile

date := "$(date +'%Y-%m-%d %H:%M')"

# Backup documents
backup:
  git add -A
  git commit -m "backup: {{date}}"
  git push
