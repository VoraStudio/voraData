# Engram — Memòria Persistent

> Engram és el sistema de memòria persistent de VoraData. Sobreviu entre sessions, eines i compactacions de context.

---

!!! info "Per a qui és això"
    Aquesta documentació és per a qualsevol agent IA que treballi al projecte. Engram permet que la memòria de decisions, convencions i descobriments no es perdi entre sessions.

---

## Què és Engram

Engram és un **servidor MCP** (Model Context Protocol). Funciona com una base de dades de memòria que l'agent pot consultar i escriure. A diferència d'un fitxer de notes, Engram permet:

- Cercar per paraula clau entre totes les sessions i projectes
- Recuperar el context de sessions anteriors al inici d'una nova
- Persistir decisions arquitectòniques, convencions i descobriments
- Funciona amb Claude Code, OpenCode i qualsevol eina compatible amb MCP

---

## Limitació important

!!! warning "Engram no té API HTTP"
    Engram és un procés MCP — **no és un servei HTTP**. Només es pot cridar des d'un client MCP actiu (Claude Code, OpenCode configurat amb MCP). No es pot cridar directament des de scripts de shell ni git hooks.

---

## Tipus de memòria

| Tipus | Quan usar |
|---|---|
| `decision` | Decisió arquitectònica, tria de tecnologia, convenció establerta |
| `bugfix` | Correcció d'error — incloure causa arrel |
| `discovery` | Descobriment no obvi sobre el codi o el projecte |
| `pattern` | Patró o convenció de nomenclatura o estructura |
| `config` | Configuració d'entorn, eines, dependències |
| `preference` | Preferència de l'equip o del projecte |

---

## Protocol d'ús

### Inici de sessió (obligatori)

```
1. mem_context (projecte: voraData) → recupera historial recent
2. Si .git/session-context.md existeix → llegir i desar events nous via mem_save
3. Continuar amb la tasca
```

### Quan desar (proactiu, sense esperar a ser demanat)

Cridar `mem_save` **immediatament** després de:

- Prendre una decisió d'arquitectura o convenció
- Corregir un error (incloure causa arrel)
- Descobrir un comportament no obvi del codi
- Establir un patró o convenció nova
- Completar una configuració d'entorn

### Tancament de sessió (obligatori)

```
mem_session_summary → resum amb: Goal, Discoveries, Accomplished, Next Steps, Relevant Files
```

---

## Integració amb git hooks

Engram no pot ser cridat directament des de git hooks (no té API HTTP). La solució a VoraData és un sistema de **fitxer de log local + lectura a inici de sessió**:

```
git commit → post-commit hook → .git/session-context.md
git push   → pre-push hook   → .git/session-context.md
                                        ↓
                          Agent llegeix a l'inici de sessió
                                        ↓
                              mem_save a Engram
```

### Format del fitxer de log

```
commit | 2026-09-16 10:30:00 | main | a1b2c3d | feat: add hero section
push   | 2026-09-16 10:31:00 | main | → origin
commit | 2026-09-16 11:00:00 | feat/landing | d4e5f6g | style: update brand colors
```

### Instal·lació dels hooks

Executa una vegada per clon:

```bash
bash scripts/setup-hooks.sh
```

Els hooks es guarden a `.hooks/` (trackat al repo) i es copien a `.git/hooks/` (local, no trackat).

---

## Configuració a OpenCode

Per usar Engram des d'OpenCode, ha d'estar configurat com a servidor MCP a `opencode.json`:

```json
{
  "mcp": {
    "engram": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@anthropic-ai/engram-mcp"]
    }
  }
}
```

!!! tip "Verifica la configuració"
    Si `mem_save` no és disponible a OpenCode, Engram no està configurat com a MCP. Comprova `opencode.json` i reinicia OpenCode.

---

## Eines disponibles

| Eina | Quan usar |
|---|---|
| `mem_save` | Desar una decisió, correcció, descobriment |
| `mem_search` | Cercar per paraula clau a la memòria |
| `mem_context` | Recuperar historial recent de la sessió |
| `mem_session_summary` | Resum obligatori al tancar sessió |
| `mem_get_observation` | Recuperar contingut complet d'un resultat |

→ Referència completa: [Engram MCP](https://github.com/anthropics/engram-mcp)
