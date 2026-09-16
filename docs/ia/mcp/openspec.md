# OpenSpec — Artefactes SDD al Repo

> OpenSpec guarda els artefactes de Spec-Driven Development com a fitxers Markdown al repositori. Tot l'equip els veu amb un simple `git pull`.

---

## Mode actiu: Hybrid

A VoraData usem el mode **hybrid**: els artefactes es desen simultàniament a OpenSpec (fitxers) i a Engram (memòria persistent).

| Backend | Responsabilitat |
|---|---|
| **OpenSpec** | Fitxers visibles per l'equip via git. Carles pot revisar proposals i specs. |
| **Engram** | Recuperació cross-sessió. Pau recupera el context a l'inici de qualsevol sessió. |

---

## Estructura de fitxers

```
openspec/
├── changes/                    ← canvis en curs
│   └── landing-clientx/        ← un directori per canvi (kebab-case anglès)
│       ├── proposal.md         ← intent, abast, enfocament
│       ├── spec.md             ← requisits i escenaris
│       ├── design.md           ← decisions tècniques i arquitectura
│       ├── tasks.md            ← llista de tasques d'implementació
│       ├── apply-progress.md   ← progrés durant l'apply
│       └── verify-report.md    ← validació contra spec
└── archive/                    ← canvis tancats i verificats
    └── landing-clientx/
        └── archive-report.md
```

---

## Cicle de vida d'un canvi

```
/sdd-new landing-clientx
    │
    ├── explore   → descobrir el codi existent
    ├── propose   → proposal.md
    ├── spec      → spec.md
    ├── design    → design.md
    ├── tasks     → tasks.md
    ├── apply     → codi + apply-progress.md
    ├── verify    → verify-report.md
    └── archive   → changes/ → archive/
```

Cada fase escriu el seu fitxer a `openspec/changes/<nom>/` **i** desa a Engram.

---

## Flux d'equip

```
Pau inicia /sdd-new → proposal.md creat
        ↓
    git push → Carles fa pull → revisa proposal.md i spec.md
        ↓
Pau continua apply → codi + verify-report.md
        ↓
    git push → Carles fa pull → revisa verify-report.md
        ↓
    /sdd-archive → canvi arxivat a openspec/archive/
```

---

## Recuperació de sessió

Si reprens un canvi en una nova sessió:

```
mem_context → historial recent
mem_search "sdd/landing-clientx/tasks" → recuperar tasques
```

Si Engram no està disponible, llegeix directament els fitxers `openspec/changes/landing-clientx/`.

---

## Normes

- **Un directori per canvi**, nom en kebab-case anglès (`landing-clientx`, `fix-navbar-mobile`)
- **Mai editar manualment** els fitxers generats per l'agent — usar les comandes SDD
- **Mai esborrar** `changes/` manualment — usar `/sdd-archive` per tancar correctament
- Els fitxers d'`archive/` són **immutables** un cop creats
- Commitejar els artefactes SDD és **opcional** però recomanat per a revisions d'equip

!!! tip "Consell sènior"
    Commitejar `proposal.md` i `spec.md` abans de l'apply et permet fer code review de la spec, no del codi. Carles pot detectar problemes de disseny molt abans — quan canviar-los no costa res.
