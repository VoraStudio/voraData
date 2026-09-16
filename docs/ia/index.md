# 🤖 IA & Herramientas

> Stack de IA local y flujos de trabajo. Todo agnóstico a la herramienta.

## Principio

El LLM es la herramienta. El equipo dirige, el LLM ejecuta. Nunca al revés.

## Stack

| Herramienta | Rol |
|---|---|
| [DGX Spark](dgx-spark.md) | Servidor IA local — modelos privados sin cloud |
| [OpenCode](opencode.md) | IDE con IA — interfaz principal de trabajo |
| Engram | Memoria persistente cross-sesión |
| MkDocs | Documentación del sistema |

## Flujo de trabajo

```
Brief → SDD (OpenCode + DGX) → Código → Review → Deploy
```

1. El brief llega a OpenCode
2. OpenCode usa el DGX Spark como backend LLM
3. El flujo SDD guía el proceso (propuesta → spec → diseño → tareas → apply)
4. El resultado se documenta aquí (MkDocs) y se archiva en Engram
