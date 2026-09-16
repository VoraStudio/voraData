#!/usr/bin/env bash
# Crea una nova decisió arquitectònica a openspec/decisions/<stack>/
#
# Ús: bash scripts/new-decision.sh <stack> "<títol>"
# Ex: bash scripts/new-decision.sh css "no usar style inline mai"
#
# Stacks vàlids: arquitectura, html, js, css, symfony

set -e

STACK=$1
TITLE=$2
VALID_STACKS="arquitectura html js css symfony"

if [[ -z "$STACK" || -z "$TITLE" ]]; then
  echo "Ús: bash scripts/new-decision.sh <stack> \"<títol>\""
  echo "Stacks: $VALID_STACKS"
  exit 1
fi

if ! echo "$VALID_STACKS" | grep -qw "$STACK"; then
  echo "Stack no vàlid: $STACK"
  echo "Stacks vàlids: $VALID_STACKS"
  exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
DIR="$REPO_ROOT/openspec/decisions/$STACK"
DATE=$(date +"%Y-%m-%d")

# Numeració automàtica (pren el màxim existent + 1)
LAST=$(ls "$DIR"/*.md 2>/dev/null | grep -oP '^\d+' | sort -n | tail -1)
NUM=$(printf "%03d" $(( ${LAST:-0} + 1 )))

# Nom de fitxer: NNN-titol-en-kebab.md
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
FILE="$DIR/${NUM}-${SLUG}.md"

cat > "$FILE" <<EOF
# $NUM — $TITLE

**Stack**: $STACK
**Estat**: acceptat
**Data**: $DATE

## Context

<!-- Per què calia decidir això? Quin problema resolia? -->

## Decisió

<!-- Què s'ha decidit exactament. -->

## Conseqüències

<!-- Avantatges, limitacions, deute tècnic, implicacions futures. -->
EOF

echo "✓ Decisió creada: openspec/decisions/$STACK/${NUM}-${SLUG}.md"
echo "  Edita el fitxer i fes commit quan estigui llest."
