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
          "name": "Qwen 3.8 27B (Visió & Multimodal)"
        }
      }
    }
  }
}
```

!!! warning "Model disponible"
    El servidor només té carregat `qwen38-27b` (SGLang). `qwen38-flash-next` no existeix en aquest backend — no usar-lo fins que estigui desplegat.

## Flux de treball

1. Obrir el projecte a OpenCode
2. Verificar connexió amb DGX Spark
3. Seguir el flux SDD: brief → proposta → spec → disseny → tasques → apply
4. Usar els presets d'aquest repo com a context per al LLM

## Skills i normes

Els skills i normes d'aquesta documentació són el context que s'injecta al LLM en cada sessió de treball.
