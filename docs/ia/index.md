# 🤖 IA & Eines

> Stack d'IA local i fluxos de treball. Tot agnòstic a l'eina.

## Principi

El LLM és l'eina. L'equip dirigeix, el LLM executa. Mai al revés.

## Stack

| Eina | Rol |
|---|---|
| [DGX Spark](dgx-spark.md) | Servidor IA local — models privats sense cloud |
| [OpenCode](opencode.md) | IDE amb IA — interfície principal de treball |
| Engram | Memòria persistent cross-sessió |
| MkDocs | Documentació del sistema |

## Flux de treball

```
Brief → SDD (OpenCode + DGX) → Codi → Review → Deploy
```

1. El brief arriba a OpenCode
2. OpenCode usa el DGX Spark com a backend LLM
3. El flux SDD guia el procés (proposta → spec → disseny → tasques → apply)
4. El resultat es documenta aquí (MkDocs) i s'arxiva a Engram
