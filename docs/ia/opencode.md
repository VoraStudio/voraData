# OpenCode

> IDE con IA. Herramienta principal de trabajo en VoraData.

## Qué es

OpenCode es el IDE con IA que usa el equipo de VoraData como interfaz de trabajo principal. Se conecta al DGX Spark local como backend LLM.

## Configuración con DGX Spark

Variables de entorno (`.env`, no versionado):

```
AI_BASE_URL="http://voradata-ia.hopto.org:30000"
AI_API_KEY="<clave del servidor>"
AI_MODEL="qwen38-27b"
```

`opencode.json` en la raíz del proyecto:

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
          "name": "Qwen 3.8 27B (Visión & Multimodal)"
        }
      }
    }
  }
}
```

!!! warning "Modelo disponible"
    El servidor solo tiene cargado `qwen38-27b` (SGLang). `qwen38-flash-next` no existe en este backend — no usarlo hasta que esté desplegado.

## Flujo de trabajo

1. Abrir proyecto en OpenCode
2. Verificar conexión con DGX Spark
3. Seguir el flujo SDD: brief → propuesta → spec → diseño → tareas → apply
4. Usar los presets de este repo como contexto para el LLM

## Skills y normas

Los skills y normas de esta documentación son el contexto que se inyecta al LLM en cada sesión de trabajo.
