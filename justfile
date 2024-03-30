#!/usr/bin/env just --justfile

# Backup documents
backup:
  git add -A
  git commit -m 'backup: $(date +"%Y-%m-%d")'
  git push
