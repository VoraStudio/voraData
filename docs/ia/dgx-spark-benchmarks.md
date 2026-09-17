# Benchmarks — DGX Spark

> Protocol de prova per als models candidats de la [proposta de multi-model routing](dgx-spark.md#proposta-futura-multi-model-routing-per-fase). Mateixa metodologia usada per verificar `qwen38-27b` (curl directe a `/v1/chat/completions`, sense passar per OpenCode, per aïllar el rendiment del model del client).

## Per què MoE i no un altre dens com `qwen38-27b`

`qwen38-27b` és un model **dens**: els seus 27B de paràmetres estan **tots actius** per a cada token que genera. Per escriure una sola paraula, el servidor ha de llegir de memòria els 27B de paràmetres sencers.

Un model **MoE** (Mixture of Experts) està format per moltes xarxes "expertes" més petites més un "router" que, per a cada token, decideix quines poques experts calen — la resta es queden inactives. Un model de 80B total amb 3B actius només llegeix 3B de paràmetres per token, encara que en guardi 80B a memòria.

!!! tip "Analogia"
    Dens = un metge que ha de repassar tot l'arxiu de l'hospital abans de contestar qualsevol pregunta d'un pacient. MoE = un hospital amb molts especialistes; per cada pacient només criden als 2-3 especialistes rellevants, no a tota la plantilla — el mateix coneixement disponible, molta menys feina per consulta.

El motiu pel qual això importa **específicament al DGX Spark**: el coll d'ampolla mesurat (~7,5 tps amb `qwen38-27b`) és l'ample de banda de memòria (273 GB/s), no el còmput. Cada token generat implica llegir els paràmetres actius de memòria — amb un dens, sempre són tots; amb un MoE, només els actius. Per això un model MoE de 80B totals amb 3B actius pot ser més ràpid en aquest maquinari que un dens de 27B, malgrat "saber" més coses en total.

Repetir el test per a cada model abans de donar-lo per bo.

| Model | Fase a provar | Tipus de petició | `max_tokens` | `chat_template_kwargs` |
|---|---|---|---|---|
| Nemotron 3 Nano Omni | A + C | Imatge (captura Figma real) + text amb `design-system.md`/`componentes.md` al prompt | 2000 | `{"enable_thinking": false}` si el template ho suporta |
| Qwen3-Coder-Next | B + D | Text només (navbar/footer/GSAP), sense imatge | 2000 | `{"enable_thinking": false}` |
| Nemotron 3 Super | E | Text, prompt amb l'HTML complet de la pàgina a auditar | 3000-4000 (revisió, no generació de zero) | Deixar thinking actiu — aquí la precisió importa més que la velocitat |
| Gemma 4 26B-A4B-it | A + C (alternativa) | Igual que Nano Omni, per comparar costat a costat | 2000 | Verificar el nom exacte del paràmetre — Gemma pot no fer servir `chat_template_kwargs` de Qwen |

## Mètriques a capturar per cada crida

Les mateixes que vam mesurar amb `qwen38-27b`:

- `finish_reason` — ha de ser `"stop"`, mai `"length"`
- `usage.reasoning_tokens` — 0 si `enable_thinking: false` ha funcionat
- Temps total de la petició (`time curl` o `%{time_total}`)
- Tokens/segon decode: `completion_tokens ÷ temps`
- **Qualitat**: el HTML reutilitza `--color-*`/`btn-*` del `design-system/`, o inventa hex nous des dels píxels de la imatge? (mateix risc que ja vam confirmar amb `qwen38-27b`)

!!! tip "Base de comparació"
    `qwen38-27b` amb `enable_thinking: false`: **52,7s / ~7,5 tps / 0 reasoning_tokens** per una secció Hero (397 tokens de sortida). Qualsevol candidat hauria de batre clarament aquest número en tps per justificar el canvi de model.
