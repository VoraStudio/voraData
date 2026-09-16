# OpenSpec — Artefactes SDD

Artefactes de Spec-Driven Development per a tots els canvis tècnics de VoraData.

## Estructura

```
openspec/
├── changes/        ← canvis en curs
│   └── <nom-canvi>/
│       ├── proposal.md
│       ├── spec.md
│       ├── design.md
│       ├── tasks.md
│       ├── apply-progress.md
│       └── verify-report.md
└── archive/        ← canvis tancats i verificats
    └── <nom-canvi>/
        └── archive-report.md
```

## Mode d'ús

Mode actiu: **hybrid** (Engram + OpenSpec)

- Els artefactes es desen als fitxers d'aquí I a Engram simultàniament
- Carles pot revisar proposals i specs fent `git pull`
- Pau recupera context cross-sessió via Engram

## Normes

- Un directori per canvi, nom en kebab-case anglès
- Mai esborrar manualment — usar `/sdd-archive` per tancar
- Els fitxers d'`archive/` no s'editen
