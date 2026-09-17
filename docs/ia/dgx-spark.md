# DGX Spark — Servidor IA Local

> El DGX Spark és el backend d'IA privat de VoraData. Totes les inferències passen per aquí — cap dada de client surt de la xarxa.

---

## Especificacions de maquinari

| Component | Detall |
|---|---|
| **Xip** | NVIDIA GB10 Grace Blackwell Superchip |
| **CPU** | 20 nuclis ARM (10 rendiment + 10 eficiència) |
| **GPU** | Blackwell — 6.144 CUDA cores |
| **Memòria** | 128 GB LPDDR5x unificada (CPU + GPU compartida) |
| **Ample de banda** | 273 GB/s |
| **Rendiment IA** | 1 PFLOP (FP4 sparse) |
| **Consum** | 240 W via USB-C |
| **Xarxa** | 10 GbE + 2× QSFP (200 Gbps agregat) |

**Punt clau**: la memòria és **unificada** — CPU i GPU comparteixen els 128 GB. Elimina la transferència CPU→VRAM, però l'ample de banda (273 GB/s) és inferior al d'una GPU discreta professional.

---

## Capacitat de models

| Configuració | Models suportats |
|---|---|
| 1 DGX Spark | Fins a ~70B paràmetres |
| 2 DGX Spark (interconnectats) | Fins a 405B paràmetres en FP4 |

**El nostre model**: `qwen38-27b` (Qwen 3.8 27B) ocupa ~27 GB en FP8. Corre còmodament amb marge sobrant per a context llarg i batching.

---

## Rendiment real — benchmarks

Mesures via **SGLang** (el mateix runtime que usem):

| Model | Quantització | Prefill (tps) | Decode batch 1 | Decode batch 32 |
|---|---|---|---|---|
| Llama 3.1 8B | FP8 | 7.991 | 20,5 | 368 |
| Llama 3.1 70B | FP8 | 803 | 2,7 | — |
| GPT-OSS 20B | MXFP4 | 2.053 | 49,7 | — |

**`qwen38-27b` estimat**: entre 8B i 70B → ~10–15 tps decode en batch 1, ~100–150 tps en batch 32.

!!! success "Verificat contra el servidor real (2026-09-17)"
    Mesura directa amb `qwen38-27b`, batch 1, `enable_thinking: false`: **~7,5 tps decode** (397 tokens de resposta en 52,7s). Amb el raonament actiu per defecte, el mateix tipus de petició pot arribar a gastar tot el pressupost de tokens pensant i no arribar mai a escriure la resposta (`finish_reason: "length"`, 0 tokens de contingut). Vegeu [OpenCode — enable_thinking](opencode.md#optimitzacio-enable_thinking-false) per al fix aplicat.

!!! tip "Actualització CES 2026"
    NVIDIA va publicar al gener 2026 una actualització de TensorRT-LLM amb speculative decoding que millora fins a **2,5× el rendiment**. Si el DGX Spark no ha rebut aquesta actualització, aplicar-la és prioritari.

---

## Punts forts per a VoraData

<div class="grid cards" markdown>

-   :material-lock:{ .lg .middle } **Privacitat total**

    ---

    Les converses amb el LLM no surten de la xarxa de VoraData. Compliment LOPD sense restriccions d'ús per a dades de clients.

-   :material-memory:{ .lg .middle } **Memòria unificada**

    ---

    128 GB compartits eliminen el límit de VRAM. Models de 27B–70B carreguen sense problemes de memòria.

-   :material-speedometer:{ .lg .middle } **Batching eficient**

    ---

    El rendiment escala molt bé amb batching. Ideal per a múltiples peticions simultànies des de l'equip.

-   :material-update:{ .lg .middle } **Millora contínua**

    ---

    NVIDIA ha doblat el rendiment des del llançament via software. El hardware millora sense canviar físicament res.

</div>

---

## Limitacions i consells

!!! warning "L'ample de banda és el coll d'ampolla"
    273 GB/s (LPDDR5x) és inferior a una GPU discreta professional. Per a decode en batch 1 (una sola conversa), el DGX Spark és ~4× més lent que una RTX Pro 6000. Per a batching elevat o models ≤30B, la diferència és poc rellevant.

| Limitació | Impacte per a VoraData | Mitigació |
|---|---|---|
| Decode lent en batch 1 | Resposta lleugerament lenta en sessions individuals | Acceptable per a ús intern |
| Models 70B+ molt lents | <3 tps — no apte per a producció | Quedar-se a models ≤30B |
| No competitiu vs GPU discreta pro | Per a RAG o inferència massiva | Escalar a clúster o model extern anonimat |
| SGLang requereix manteniment | Actualitzacions manuals necessàries | Documentar versió activa |

---

## Casos d'ús recomanats

| Cas d'ús | Viable? | Notes |
|---|---|---|
| Assistència de codi (OpenCode) | ✅ Ideal | `qwen38-27b` és un model de codi potent |
| Generació de text per a clients | ✅ Viable | Resposta <3s per prompts normals |
| Revisió de codi i refactorització | ✅ Viable | Context llarg ben suportat |
| RAG sobre documentació interna | ✅ Viable | Amb embedding local |
| Inferència en batch per a automatitzacions | ✅ Molt bo | El batching escala molt bé |
| Models >70B en producció | ❌ No recomanat | <3 tps és massa lent |
| Substitució d'una GPU discreta pro | ❌ No | Per a càrregues de treball molt intenses |

---

## Configuració actual

| Paràmetre | Valor |
|---|---|
| Endpoint | `http://voradata-ia.hopto.org:30000` |
| Model actiu | `qwen38-27b` |
| Runtime | SGLang |
| Provider OpenCode | `@ai-sdk/openai-compatible` |

Les credencials van al fitxer `.env` (mai al repo):

```bash
AI_BASE_URL="http://voradata-ia.hopto.org:30000/v1"
AI_API_KEY="la-clau-aqui"
AI_MODEL="qwen38-27b"
```

---

## Proposta futura — Multi-Model Routing per fase

!!! warning "No verificat en el nostre maquinari"
    Basat en benchmarks públics (2026-09-16), no en proves pròpies contra el Spark de VoraData. Portar-ho a qui gestioni la infra del DGX com a proposta a testejar, no com un canvi a adoptar directament.

En un equip limitat per ample de banda de memòria com el Spark (273 GB/s), **el nombre de paràmetres actius decideix la velocitat de decode, no el total de paràmetres**. Un model MoE (Mixture of Experts) dispers amb pocs paràmetres actius per token supera consistentment un model dens de mida similar en aquest maquinari.

<div class="grid cards" markdown>

-   :material-star:{ .lg .middle } **Recomanació #1 — Nemotron 3 Nano Omni**

    ---

    30B total, **3B actiu** (MoE), NVFP4 ~21GB. Model de referència de NVIDIA per a DGX Spark, nativament multimodal (text/imatge) — cobreix la lectura de captures de Figma sense una crida de visió separada.

    Benchmarks públics: **~74-108 tps** vs els ~7,5 tps mesurats avui amb `qwen38-27b` — potencialment 10-14× més ràpid per al cas d'ús principal (imatge → HTML).

-   :material-code-braces:{ .lg .middle } **Recomanació #2 — Qwen3-Coder-Next**

    ---

    80B total, 3B actiu (MoE), 256K de context, ~70% SWE-Bench. Purpose-built per a agents de codi. Per a fases sense visió (navbar/footer, animació GSAP) on la tasca és mecànica i seguir instruccions importa més que interpretar una imatge.

-   :material-magnify-scan:{ .lg .middle } **Recomanació #3 — Nemotron 3 Super**

    ---

    120B total, 12B actiu (MoE). Més lent que els anteriors (~19,5 tps) però més paràmetres actius = més capacitat de detectar errors. Reservat per a una auditoria final (un sol pas per pàgina, no iteratiu), on la latència extra és assumible a canvi de més precisió.

</div>

**Com enrutar-ho**: no és SDD (això planifica canvis de codi al repo, no generació de contingut per fase). El mecanisme correcte és l'assignació de model per agent que ja existeix a OpenCode — un agent per rol (`landing-vision`, `landing-coder`, `landing-auditor`), cada un amb el seu `model` apuntant al model DGX corresponent.

**Ordre de prioritat per provar**: Nemotron 3 Nano Omni primer (cobreix el cas d'ús més freqüent, imatge+codi), Qwen3-Coder-Next després (fases sense imatge). Abans d'adoptar-ho a producció, repetir el mateix tipus de test fet avui amb `qwen38-27b` (imatge real + `design-system.md` al prompt, mesurar temps i qualitat de l'HTML resultant).

---

## Quan usar un LLM extern

!!! danger "Regla LOPD"
    Si per alguna raó cal usar Claude, GPT o qualsevol LLM extern, **mai** incloure dades de clients al prompt. Usar sempre dades anonimitzades o fictícies.

Casos on pot tenir sentit:
- Tasques creatives on `qwen38-27b` no arriba al nivell necessari
- Anàlisi amb context molt gran (>128K tokens)
- Accés a eines externes (browsing, imatges)

Sempre amb dades anonimitzades. Mai amb contractes, emails ni dades personals de clients.
