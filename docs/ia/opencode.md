# OpenCode

> IDE amb IA. Eina principal de treball a VoraData.

## Què és

OpenCode és l'IDE amb IA que fa servir l'equip de VoraData com a interfície de treball principal. Es connecta al DGX Spark local com a backend LLM.

## Configuració amb DGX Spark

Variables d'entorn (`.env`, no versionat):

```
AI_BASE_URL="http://voradata-ia.hopto.org:30000"
AI_API_KEY="<clau del servidor>"
AI_MODEL="qwen38-27b"
```

`opencode.json` a l'arrel del projecte:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "dgx-spark": {
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "baseURL": "{env:AI_BASE_URL}/v1",
        "apiKey": "{env:AI_API_KEY}"
      },
      "models": {
        "qwen38-27b": {
          "name": "Qwen 3.8 27B (Visió & Multimodal)",
          "limit": {
            "context": 65536,
            "output": 2000
          },
          "options": {
            "extraBody": {
              "chat_template_kwargs": { "enable_thinking": false }
            }
          }
        }
      }
    }
  }
}
```

!!! warning "Model disponible"
    El servidor només té carregat `qwen38-27b` (SGLang). `qwen38-flash-next` no existeix en aquest backend — no usar-lo fins que estigui desplegat.

## Optimització: `enable_thinking: false`

`qwen38-27b` és un model de raonament — abans d'escriure la resposta final, genera un "esborrany" intern (`reasoning_content`) que consumeix el mateix pressupost de tokens (`max_tokens`) que la resposta real. Sense control, l'esborrany es pot menjar tot el pressupost i tallar la resposta a mitges.

<div class="grid cards" markdown>

-   :material-bug:{ .lg .middle } **Problema detectat**

    ---

    Petició de generació HTML amb `max_tokens: 1500`, configuració per defecte (sense `enable_thinking: false`):

    - **196 segons** de resposta
    - `finish_reason: "length"` (tallada)
    - 1500/1500 tokens gastats en raonament
    - **0 caràcters** de contingut útil

-   :material-wrench:{ .lg .middle } **Solució aplicada**

    ---

    Afegir a `opencode.json`, dins del model:

    ```json
    "options": {
      "extraBody": {
        "chat_template_kwargs": {
          "enable_thinking": false
        }
      }
    }
    ```

    Això li diu al model que salti l'esborrany intern i escrigui la resposta directament.

-   :material-chart-line:{ .lg .middle } **Guany mesurat**

    ---

    Mateixa petició, amb `enable_thinking: false`:

    - **52 segons** (~3.7x més ràpid)
    - `finish_reason: "stop"` (completa)
    - 0 tokens gastats en raonament
    - HTML vàlid i complet

</div>

!!! tip "No és gratis"
    Sense raonament, el model també defalteja més fàcilment a colors/classes de Tailwind per defecte si no se li donen els tokens del `design-system/` al prompt. La revisió humana per fase segueix sent obligatòria — vegeu [Generació a partir d'una imatge de referència](../presets/landing/design-system.md#generacio-a-partir-duna-imatge-de-referencia-figmapdf).

## Flux de treball

1. Obrir el projecte a OpenCode
2. Verificar connexió amb DGX Spark
3. Seguir el flux SDD: brief → proposta → spec → disseny → tasques → apply
4. Usar els presets d'aquest repo com a context per al LLM

## Skills i normes

Els skills i normes d'aquesta documentació són el context que s'injecta al LLM en cada sessió de treball.
