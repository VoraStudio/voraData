# Com estructurem AGENTS.md

> `AGENTS.md` deixa de ser un manual llarg i passa a ser un **router**: poques regles dures a dins i, per a cada fase, quins fitxers cal llegir abans d'actuar.

!!! warning "En validació"
    Aquesta pàgina documenta la **proposta** (`SDD-VD/AGENTS.proposta.md`) secció per secció, amb el que s'ha comprovat amb el model local (Qwen3.8 27B al DGX Spark). Les seccions 7, 8 i 9 encara no estan tancades.

## Per què un router

L'`AGENTS.md` antic és un sol fitxer llarg: identitat, stack, normes de codi, hooks, automatitzacions, lliurament, LOPD i mapa del repositori. L'eina el carrega **a l'inici de cada sessió**, tant si la tasca el necessita com si no.

Ho hem vist a les proves: el model sabia que treballava per a VoraData sense que ningú li ho digués al prompt, perquè OpenCode li injecta l'`AGENTS.md` de l'arrel. Tot el que hi posem, el model ho llegeix sempre.

| Fitxer llarg | Router curt |
|---|---|
| Tot el context es carrega sempre | Es carrega el mínim i la resta només quan toca |
| Les regles importants queden enterrades entre detalls | Les regles dures són visibles i inline |
| El mateix detall viu en dos llocs | El detall viu en un sol fitxer; `AGENTS.md` només l'apunta |

**Criteri de tota la proposta:** a `AGENTS.md` hi va només el que costa car d'oblidar i s'aplica sempre. El que només serveix en una fase es llegeix quan arriba aquella fase.

## Mapa de seccions

| # | Secció | Tipus | Estat |
|---|---|---|---|
| 1 | Qui som | Inline | Redactada |
| 2 | Rol de l'agent | Inline | Redactada |
| 3 | Regles dures | Inline | Redactada |
| 4 | Idiomes | Inline | Redactada |
| 5 | Stack | Inline | Redactada |
| 6 | Router de fases | Inline | Redactada; la fila d'INTAKE s'ha d'actualitzar |
| 7 | Protocol HITL | Inline (4-6 línies) | Esbós |
| 8 | Memòria i persistència | Inline (3-4 línies) | Esbós |
| 9 | Fora d'aquest fitxer | Només referència | Llista feta; migració pendent |

---

## 1. Qui som

**Contingut:**

- VoraData és una consultora de transformació digital: landing pages, aplicacions SaaS, IA local i privada, solucions a mida.
- Equip: **Pau** (webmaster, perfil pre-junior), **Carles** (sènior, backend) i **VoraStudio** (branca creativa: disseny, Figma, marca).
- Els projectes arriben com a **imatges de cada secció** (Canvas o Figma) i el **brand** (colors i tipografies). El disseny ÉS el brief: no hi ha document de requisits.

**Per què:** només fets. El comportament de l'agent no va aquí, sinó a la secció 2. Així, si canvia l'equip o el tipus de projecte, es toca un sol lloc.

## 2. Rol de l'agent

**Contingut:**

- Enginyer sènior: executa i proposa, **no decideix**.
- Ensenya a Pau el PER QUÈ de cada decisió, no només el QUÈ.
- Qui decideix: IA, flux i agent → Pau. Backend i SaaS → Carles.
- Disseny: reprodueix el de VoraStudio **sense reinterpretar-lo**; si falta informació, pregunta.
- Verifica abans d'afirmar; si Pau s'equivoca, ho diu amb evidència.

**Per què:** l'agent no pot decidir sol perquè no respon de les conseqüències. "Sense reinterpretar" és el que després comprova tota la fase INTAKE: si l'agent "millora" el disseny, ja no és el del client.

## 3. Regles dures

**Contingut:**

- Cap instrucció de git (`commit`, `push`, `merge`...) ni desplegament sense indicació prèvia explícita.
- Commits convencionals, en anglès, sense atribució a IA.
- LOPD: cap dada, credencial ni asset de client al repositori.
- Stack tancat: cap dependència nova sense consens.
- Cap `<style>` (excepte `text/tailwindcss` amb `@theme`), cap `<script>` inline, cap `on*=`.
- Escalació: parar i preguntar si toca arquitectura, l'abast és ambigu o el canvi pot tenir efectes secundaris no evidents.
- Abast: res de funcionalitat no demanada ni refactors fora de la tasca.

**Per què inline:** una regla es queda aquí si oblidar-la costa car i no es pot desfer fàcilment (un push, una dada de client al repo públic). Si fos només un enllaç, el model podria no anar-lo a buscar.

!!! note "Què hem après a les proves"
    Escriure una regla no garanteix que el model la compleixi. A les primeres proves d'INTAKE, Qwen va llegir el PDF amb eines que el flux prohibia i va desar imatges que no se li havien demanat. Va deixar de fer-ho quan la regla va passar a ser **concreta** (quines eines no pot fer servir, quins fitxers no pot escriure). Una regla genèrica ("no ho llegeixis amb cap altra eina") no va ser prou.

## 4. Idiomes

**Contingut:** documentació i comentaris en català · codi en anglès · commits en anglès · xat en castellà o català.

**Per què:** una sola línia n'hi ha prou. El model la necessita a cada resposta, i és curta.

## 5. Stack

**Contingut:** HTML semàntic + Tailwind CSS v4 + Vanilla JS · Symfony · DGX Spark (SGLang) · MkDocs + Material · GitHub. Una línia sobre el lliurament sense build (Tailwind i GSAP per CDN, `@theme` en línia) que apunta a `docs/presets/landing/normas.md`.

**Per què:** la taula curta evita que el model proposi eines de fora de l'stack. El detall tècnic del lliurament viu en un sol fitxer i aquí només s'apunta.

## 6. Router de fases

**Contingut:** al començar, l'agent confirma amb Pau el tipus de projecte i la fase abans de llegir res. En una landing segueix l'ordre **INTAKE → BUILD → DELIVER**, no passa de fase sense l'aprovació de Pau i només llegeix els fitxers de la fase actual.

Cada fase té la mateixa forma, perquè el model la reconegui sense reinterpretar-la:

| Camp | Pregunta |
|---|---|
| **Quan** | En quina situació som? |
| **Llegeix** | Quins fitxers he de carregar abans d'actuar? |
| **Fes** | Quina és la tasca d'aquesta fase? |
| **Acaba quan** | Quina aprovació necessito abans de continuar? |

### Fase 1 · INTAKE

| Camp | A la proposta | Com ha de quedar (segons les proves) |
|---|---|---|
| Quan | Projecte nou amb disseny i marca, sense tokens confirmats | Igual |
| Llegeix | `docs/sdd/landing/intake.md` + `design-system.md` | **`SDD-VD/intake.proposta.md`** (el flux nou) |
| Fes | Extreure tokens (colors, fonts, espaiat) i inventari d'actius | Les 3 parts d'INTAKE, cadascuna amb parada |
| Acaba quan | Pau confirma tokens i inventari | Pau confirma les 3 parts i el resultat és a `intake-result.md` |

**Què hem aconseguit a INTAKE i per què:**

| Part | Problema detectat | Solució | Resultat amb Qwen |
|---|---|---|---|
| 1 · Colors | El model llegia bé els valors però els **comparava** malament: aparellava colors pel nom, inventava discrepàncies i cada execució fallava en una cosa diferent | Script `brand_cards.py`: agrupa el text per targeta de color, calcula totes les discrepàncies i el model només les copia | 3 de 3 execucions idèntiques i correctes |
| 1 · Tipografia | Inventava rols (títol, cos) i pesos que el PDF no deia | Regles concretes: pesos tal com estan escrits, "no consta" si no hi ha rols ni escala | 3 de 3 sense inventar; 1 de 3 va corregir una errata en silenci |
| 2 · Components | L'ull del model no mesura: botons, camps i etiquetes amb mides errònies, vores fines mal llegides | Script `ui_metrics.py`: mesura cada component (mida, farciment, vora, radi) i dona la classe de Tailwind; el model la copia | 23 de 23 components amb l'estil fidel |
| 2 · Notes vs dibuix | El manual es contradiu (una nota diu 30px i el dibuix fa 23) | Regla: llistar els dos valors; decideix Pau | El model ho llista i no tria |

!!! tip "El patró que ha funcionat"
    El que es pot **mesurar** (colors, mides, vores) ho fa un script, amb tests; el model només copia i presenta. El que és **judici** (què vol dir una nota, com es presenta a Pau) ho fa el model. Cada vegada que hem deixat una comparació a mans del model, ha fallat de manera diferent a cada execució.

**Encara falla (lectura d'imatge):** textos petits transcrits amb errors i una nota amb un color pel nom ("morat viu") que el model no tradueix al token. La Part 3 (seccions i actius) no s'ha provat.

### Fase 2 · BUILD

| Camp | Valor |
|---|---|
| Quan | Els tokens estan confirmats i cal escriure HTML |
| Llegeix | `docs/presets/landing/componentes.md` + `docs/presets/landing/normas.md` |
| Fes | Construir per blocs seguint el protocol HITL (secció 7); recursos a `docs/presets/landing/recursos.md` si cal |
| Acaba quan | Pau aprova el BUILD |

**Per què:** construir per blocs amb aturades evita arribar al final amb una pàgina sencera que no s'assembla al disseny. Encara no s'ha provat amb el flux nou.

### Fase 3 · DELIVER

| Camp | Valor |
|---|---|
| Quan | Pau ha aprovat el BUILD |
| Llegeix | `docs/normes/lliurament.md` |
| Fes | Completar el checklist (rendiment, SEO, a11y, cross-browser) |
| Acaba quan | Pau aprova el lliurament |

### Altres casos

- Projecte SaaS: `docs/sdd/index.md` + `docs/sdd/fases.md` (*pendent de definir*).
- Decisió d'arquitectura fora de SDD: `openspec/README.md`.

## 7. Protocol HITL

**Contingut (esbós):** aturada després de cada bloc major (hero, body, footer); cap crida a eina fins a la confirmació humana; format de la frase de parada i del log per definir.

**Per què inline:** és la regla que més es trenca en construcció. Si el model no para, l'humà perd el control del que s'està fent.

**Què sabem:** a INTAKE, les aturades han funcionat en totes les execucions vàlides. En benchmarks anteriors de BUILD, el model es va saltar aturades entre blocs. Per això cal definir un format de parada concret.

## 8. Memòria i persistència

**Contingut (esbós):** mode hybrid (Engram entre sessions + OpenSpec en fitxers de git). A l'inici: llegir aquest fitxer, identificar el tipus de projecte, confirmar l'abast.

**Què hem après:** durant les proves la memòria **contamina**. En una prova, el model va consultar Engram pel seu compte i la prova es va haver de descartar. Les proves fiables s'han fet amb Engram, context7 i codegraph desactivats.

## 9. Fora d'aquest fitxer

**Contingut:** el que ha de sortir d'`AGENTS.md` i viure als fitxers de detall.

| Contingut | On viu |
|---|---|
| Hooks git i la seva instal·lació | `scripts/` i `.hooks/` |
| GitHub Actions | `.github/workflows/` |
| Mapa complet del repositori | Documentació |
| Normes de codi detallades | `docs/normes/codi.md` |
| Normes de lliurament i LOPD llarga | `docs/normes/lliurament.md` i `docs/normes/seguretat.md` |
| Llistat de skills | `docs/presets/skills.md` |

**Per què:** tot això és necessari, però no a cada resposta. Llegir-ho sempre gasta context i dilueix les regles dures.

---

## Pendent

| Element | Què falta |
|---|---|
| Fila INTAKE del router | Apuntar a `SDD-VD/intake.proposta.md` i reflectir les 3 parts |
| Secció 7 — HITL | Format de la frase de parada i del log |
| Secció 8 — Memòria | Redacció definitiva |
| Secció 9 — Migració | Moure realment aquests continguts |
| Validació del router | Un benchmark on el log mostri que el model llegeix els fitxers correctes a cada fase |
| Decisions obertes | `skill-registry.md` sencer o per fase · `design.md` un fitxer o per fase · flux SaaS ara o pendent |

## Continua

[Normes del workflow](index.md) · [Fases del flux SDD](../fases.md)
