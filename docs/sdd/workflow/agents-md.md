# Com estructurem AGENTS.md

> `AGENTS.md` deixa de ser un manual llarg i passa a ser un **router**: poques regles dures a dins i una taula que diu "quan passi X, llegeix Y abans d'actuar".

!!! warning "En validació"
    Aquesta estructura és una **proposta** (`SDD-VD/AGENTS.proposta.md`). Encara no s'ha validat amb un benchmark que confirmi que el model llegeix els fitxers correctes a cada fase. Les seccions 7 i 8 estan només esbossades.

## El problema que resol

L'`AGENTS.md` actual és un sol fitxer llarg: identitat, stack, normes de codi, hooks, automatitzacions, lliurament, LOPD, mapa del repositori. El model el carrega **sencer a cada sessió**, tant si la tasca el necessita com si no.

| Fitxer llarg | Router curt |
|---|---|
| Tot el context es carrega sempre | Es carrega el mínim i la resta només quan toca |
| Les regles importants queden enterrades entre detalls | Les regles dures són visibles i inline |
| Difícil de mantenir: el mateix detall viu en dos llocs | El detall viu en un sol fitxer; `AGENTS.md` només l'apunta |

## La idea en una frase

Al fitxer que l'agent **sempre** llegeix hi va només el que costa car d'oblidar. Tot el que només serveix en una fase concreta es llegeix **quan arriba aquella fase**.

## Estructura de la proposta (9 seccions)

| # | Secció | Tipus | Contingut |
|---|---|---|---|
| 1 | Qui som | Inline | Què fa VoraData, equip, com arriben els projectes (el disseny ÉS el brief) |
| 2 | Rol de l'agent | Inline | Executa i proposa, no decideix; qui decideix què; ensenyar el PER QUÈ |
| 3 | **Regles dures** | Inline | Les que costen car si s'obliden (vegeu sota) |
| 4 | Idiomes | Inline | Docs i comentaris en català, codi i commits en anglès |
| 5 | Stack | Inline | Taula curta + una línia sobre el lliurament sense build |
| 6 | **Router de fases** | Inline | Taula "quan → llegeix → fes → acaba quan" |
| 7 | Protocol HITL | Inline (4-6 línies) | Pendent |
| 8 | Memòria i persistència | Inline (3-4 línies) | Engram + OpenSpec (hybrid) |
| 9 | Fora d'aquest fitxer | Només referència | Llista del que **no** ha de viure aquí |

## Regles dures inline: per què

Una regla es queda inline si **oblidar-la costa car i no es pot recuperar fàcilment**. La proposta en fixa set:

- Cap instrucció de git ni desplegament sense indicació explícita.
- Commits convencionals, en anglès, sense atribució a IA.
- LOPD: cap dada, credencial ni asset de client al repositori.
- Stack tancat: cap dependència nova sense consens.
- Cap `<style>` (excepte `text/tailwindcss` amb `@theme`), cap `<script>` inline, cap `on*=`.
- Escalació: parar i preguntar si toca arquitectura, l'abast és ambigu o el canvi pot tenir efectes secundaris.
- Abast: res de funcionalitat no demanada ni refactors fora de la tasca.

!!! tip "Per què no són un enllaç"
    Si una regla dura fos només un enllaç a un altre fitxer, el model podria no seguir-lo. Una regla que ha de complir-se **sempre** no pot dependre que algú la vagi a buscar.

## El router de fases

Cada entrada de la secció 6 té la mateixa forma, de manera que el model la pot reconèixer sense reinterpretar-la:

| Camp | Pregunta a la qual respon |
|---|---|
| **Quan** | En quina situació som? |
| **Llegeix** | Quins fitxers he de carregar abans d'actuar? |
| **Fes** | Quina és la tasca d'aquesta fase? |
| **Acaba quan** | Quina aprovació necessito abans de continuar? |

Exemple, tal com queda per a INTAKE:

| Camp | Valor |
|---|---|
| Quan | Arriba un projecte nou amb disseny i marca, i encara no hi ha tokens confirmats |
| Llegeix | `docs/sdd/landing/intake.md` + `docs/presets/landing/design-system.md` |
| Fes | Extreu els tokens (colors, fonts, espaiat) i l'inventari d'actius |
| Acaba quan | Pau confirma els tokens i l'inventari |

El router també diu **que no es passa a la fase següent sense l'aprovació de Pau** i que només es llegeixen els fitxers de la fase actual. Els altres casos (SaaS, decisions d'arquitectura fora de SDD) hi surten com a entrades apart; el flux SaaS consta com a *pendent de definir*.

## Què surt d'AGENTS.md

La secció 9 llista el que es mou als fitxers de detall. Aquí només hi queda la referència.

| Contingut | On viu |
|---|---|
| Hooks git i la seva instal·lació | `scripts/` i `.hooks/` |
| GitHub Actions | `.github/workflows/` |
| Mapa complet del repositori | Documentació |
| Normes de codi detallades | `docs/normes/codi.md` |
| Normes de lliurament i LOPD llarga | `docs/normes/lliurament.md` i `docs/normes/seguretat.md` |
| Llistat de skills | `docs/presets/skills.md` |

## Com validar-ho

La proposta no dona per bo el router: cal comprovar-ho. El criteri és que **el log del benchmark mostri que el model llegeix els fitxers correctes a cada fase** i cap altre.

## Pendent

| Element | Què falta |
|---|---|
| Secció 7 — Protocol HITL | Definir el format de la frase de parada i del log; la proposta només indica un punt d'aturada després de cada bloc major i cap crida a eina fins a la confirmació humana |
| Secció 8 — Memòria | Redactar-la definitivament; ara només fixa el mode hybrid i les tres accions d'inici de sessió |
| Secció 9 — Migració | Moure realment aquests continguts als seus fitxers de detall |
| Flux SaaS | Decidir si es defineix ara o es deixa com a pendent al router |

## Continua

[Normes del workflow](index.md) · [Fases del flux SDD](../fases.md)
