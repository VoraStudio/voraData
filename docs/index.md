# VoraData — Docs

> Arquitectura, fluxos SDD, presets i normes tècniques de VoraData.

---

## Què trobaràs aquí

<div class="grid cards" markdown>

-   :material-book-check:{ .lg .middle } **Normes Globals**

    ---

    Les regles base de l'empresa: codi, git, lliurament i seguretat. El punt de partida per a qualsevol projecte.

    [:octicons-arrow-right-24: Veure normes](normes/index.md)

-   :material-refresh:{ .lg .middle } **SDD**

    ---

    Fluxos Spec-Driven Development adaptats: Landing Workflow i SaaS Workflow.

    [:octicons-arrow-right-24: Veure fluxos](sdd/index.md)

-   :material-palette:{ .lg .middle } **Presets**

    ---

    Sistema de disseny Tailwind, catàleg de components i normes tècniques reutilitzables.

    [:octicons-arrow-right-24: Veure presets](presets/index.md)

-   :material-robot:{ .lg .middle } **IA & Eines**

    ---

    Configuració del DGX Spark, OpenCode i fluxos de treball amb IA local.

    [:octicons-arrow-right-24: Veure eines](ia/index.md)

</div>

---

## Stack

| Capa | Tecnologia |
|---|---|
| Frontend | Vanilla JS + HTML + Tailwind CSS v4 |
| Backend | Symfony (PHP) |
| IA local | DGX Spark + OpenCode |
| Docs | MkDocs + Material |

!!! tip "Principi fonamental"
    Tot el que es construeix aquí és **agnòstic a l'eina**. Funciona amb qualsevol LLM — local (DGX Spark) o cloud.
