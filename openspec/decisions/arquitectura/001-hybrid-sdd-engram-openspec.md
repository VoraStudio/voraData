# 001 — Mode hybrid: Engram + OpenSpec com a artifact store SDD

**Stack**: arquitectura
**Estat**: acceptat
**Data**: 2026-09-16

## Context

Necessitàvem un sistema de memòria persistent per a decisions SDD que funcionés tant per a la recuperació cross-sessió de l'agent com per a la revisió per part de Carles.

Engram (MCP) permet recuperació entre sessions però no té API HTTP — no és accessible sense un client MCP actiu. OpenSpec (fitxers Markdown) és accessible per qualsevol eina però no fa recuperació automàtica de context.

## Decisió

Mode **hybrid**: els artefactes SDD es desen simultàniament a `openspec/` (fitxers) i a Engram (memòria). Les decisions fora de SDD van a `openspec/decisions/<stack>/`.

## Conseqüències

- Carles pot revisar proposals i specs amb `git pull`, sense necessitat de tenir Engram configurat
- L'agent recupera context complet a l'inici de sessió via `mem_context`
- Cost: doble escriptura per artefacte SDD (acceptable)
- Les decisions fora de SDD requereixen executar `bash scripts/new-decision.sh` manualment o que l'agent les escrigui proactivament
