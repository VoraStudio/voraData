#!/usr/bin/env bash
# Instal·la els hooks de git des de .hooks/ a .git/hooks/
# Executa una vegada després de clonar el repositori.
set -e

REPO_ROOT=$(git rev-parse --show-toplevel)
HOOKS_SRC="$REPO_ROOT/.hooks"
HOOKS_DST="$REPO_ROOT/.git/hooks"

for hook in "$HOOKS_SRC"/*; do
  name=$(basename "$hook")
  dst="$HOOKS_DST/$name"
  cp "$hook" "$dst"
  chmod +x "$dst"
  echo "✓ Hook instal·lat: $name"
done

echo ""
echo "✓ Tots els hooks instal·lats correctament."
echo "  Els events de commit i push es registraran a .git/session-context.md"
