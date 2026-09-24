# Configuració D2 — DGX Spark

> Després de comparar 5 configuracions del `Qwen3.8-27B` al DGX Spark, la guanyadora és **D2**: model **NVFP4** + **MTP**. Aquesta pàgina explica què és, què canvia i per què la vam triar.

## Què canvia respecte a abans

<div class="grid cards" markdown>

-   :material-weight:{ .lg .middle } **Model més "comprimit" (NVFP4)**

    ---

    Abans: pesos en FP8 (~28 GB). Ara: pesos en NVFP4 (~14 GB). Són els mateixos coneixements guardats amb menys precisió numèrica, com passar una foto de PNG a JPG.

-   :material-fast-forward:{ .lg .middle } **Genera diversos tokens per pas (MTP)**

    ---

    Abans: 1 paraula (token) per pas. Ara el model n'"endevina" diverses alhora i les verifica. De mitjana n'accepta ~2 per pas.

-   :material-server:{ .lg .middle } **Servidor SGLang**

    ---

    El model corre sobre SGLang, que és qui aplica el MTP. Es desplega amb `infra/spark/serve-qwen38.sh`.

-   :material-key:{ .lg .middle } **Autenticació blindada**

    ---

    El nou script s'atura si la clau d'API surt buida i verifica, un cop arrencat, que una petició sense clau es rebutja.

</div>

---

## Per què les dues millores se sumen

El Spark va lent per **l'ample de banda de la memòria**, no per potència de càlcul: cada token obliga a llegir tots els pesos del model.

- **NVFP4** → pesos més petits → menys bytes a llegir per token.
- **MTP** → més tokens per cada lectura.

Atacant dos punts diferents del mateix coll d'ampolla, els guanys es multipliquen en lloc de solapar-se.

| Configuració | Tokens/s | Vegades més ràpid que A |
|---|---|---|
| A — BF16 → FP8 al vol (base) | 7,4 | 1× |
| B — FP8 oficial | 7,5 | 1× |
| D — NVFP4 sol | 11,8 | 1,6× |
| C — FP8 + MTP | 15,2 | 2,1× |
| **D2 — NVFP4 + MTP** | **24,5** | **3,3×** |

---

## Avantatges

<div class="grid cards" markdown>

-   :material-rocket-launch:{ .lg .middle } **3,3× més ràpid**

    ---

    24,5 tokens/s davant dels 7,4 de la base. Una resposta que trigava ~2 minuts en triga ~40 s.

-   :material-timer-sand:{ .lg .middle } **Primera resposta més ràpida**

    ---

    El temps fins al primer token baixa de ~3 s a ~1,8 s: pesos més petits també acceleren la lectura del prompt.

-   :material-account-group:{ .lg .middle } **Aguanta 3 usuaris alhora**

    ---

    Amb 3 peticions simultànies el Spark no es satura (67 tokens/s en total) i cada usuari gairebé no nota la diferència.

-   :material-check-decagram:{ .lg .middle } **Qualitat mantinguda**

    ---

    En les proves, el codi revisat i l'HTML generat eren tan bons com amb FP8, fins i tot millor estructurats.

-   :material-harddisk:{ .lg .middle } **Ocupa la meitat**

    ---

    ~14 GB en lloc de ~28 GB: deixa més memòria lliure per a context llarg i més usuaris.

</div>

---

## Desavantatges

<div class="grid cards" markdown>

-   :material-package-variant:{ .lg .middle } **Model de tercers**

    ---

    L'NVFP4 el publica RadixArk, no Qwen. És més còmode confiar en el model oficial, per això conservem l'FP8 com a pla B.

-   :material-flask:{ .lg .middle } **Qualitat provada només amb una mostra**

    ---

    Hem revisat poques respostes. Cal seguir vigilant la qualitat amb feina real abans de donar-ho per definitiu.

-   :material-brain:{ .lg .middle } **`xhigh` no serveix per a feina interactiva**

    ---

    Amb raonament `xhigh` la resposta es talla als 4096 tokens sense acabar (~211 s). Fem servir `medium`.

-   :material-speedometer-slow:{ .lg .middle } **Encara no és el més ràpid possible**

    ---

    Un model MoE com `Qwen3.6-35B-A3B-NVFP4` podria ser ~2,3× més ràpid al mateix maquinari. D2 és el millor dels **densos**.

</div>

---

## Consells ràpids

!!! tip "Per què no provar només NVFP4 o només MTP?"
    Ho vam fer (configuracions C i D). Cadascuna sola dona 1,6×–2,1×; juntes, 3,3×.

!!! warning "Sempre validar que hi ha autenticació"
    Durant el benchmark el servidor va córrer sense clau d'API per un error de muntatge. Després de desplegar, comprova que `./serve-qwen38.sh status` digui **"Autenticació activa"**.

!!! note "Els números són amb 1 usuari"
    Els 24,5 tokens/s són amb un sol usuari. Amb més usuaris el total puja, però el ritme per usuari baixa lleugerament.
