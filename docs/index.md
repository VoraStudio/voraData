# VoraData — Docs

---

## Últimes actualitzacions

> Secció mantinguda per l'agent IA — s'actualitza cada vegada que es modifica aquesta documentació. Consulta-la per saber què ha canviat recentment sense haver de repassar tot el repo.

| Data | Secció | Què va canviar |
|---|---|---|
| 2026-09-17 | [IA & Eines → DGX Spark → Benchmarks](ia/dgx-spark-benchmarks.md) | Nova subpàgina amb el protocol de benchmark per model/fase (paràmetres exactes de la petició i mètriques a capturar) |
| 2026-09-17 | [Presets → Landing → Recursos](presets/landing/recursos.md) | Nova subpàgina de recursos per a la fase de disseny en Figma (components, icones, color, tipografia) |
| 2026-09-17 | [IA & Eines → DGX Spark](ia/dgx-spark.md#casos-dus-recomanats) | Corregida taula de "Casos d'ús recomanats" — l'estimació de "<3s per prompts normals" no es sostenia amb els ~7,5 tps mesurats |
| 2026-09-17 | [IA & Eines → DGX Spark](ia/dgx-spark.md#proposta-futura-multi-model-routing-per-fase) | Proposta de multi-model routing per fase (Nemotron 3 Nano Omni, Qwen3-Coder-Next) + benchmark real de `qwen38-27b` verificat |
| 2026-09-17 | [IA & Eines → OpenCode](ia/opencode.md#optimitzacio-enable_thinking-false) | Fix `enable_thinking: false` documentat i verificat contra el servidor (196s→52s) |
| 2026-09-17 | [Presets → Landing](presets/landing/index.md) | Fixes de tokens, botons, arquitectura single-page, pressupost GSAP i `prefers-reduced-motion` |
| 2026-09-17 | [AGENT.md](https://github.com/VoraStudio/voraData/blob/main/AGENT.md) i presets | Substitució de Canva per Figma (versió gratuïta) com a eina de la dissenyadora |
| 2026-09-17 | [Normes globals](normes/index.md) | Excepcions afegides: arquitectura single-page per a landings, pressupost GSAP al checklist de lliurament |

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
