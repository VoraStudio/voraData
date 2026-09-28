# Fases del flux SDD

> Referència ràpida de cada fase: què produeix, què consumeix i criteri de sortida.

## Diagrama de dependències

```mermaid
graph LR
    A[Proposta] --> B[Spec]
    A --> C[Disseny]
    B --> D[Tasques]
    C --> D
    D --> E[Apply]
    E --> F[Verificació]
    F --> G[Arxiu]
```

## Fases

### Proposta
- **Consumeix**: brief del client
- **Produeix**: abast, objectius, restriccions, no-goals
- **Criteri de sortida**: equip alineat en QUÈ es construeix

### Spec
- **Consumeix**: proposta aprovada
- **Produeix**: requisits funcionals i escenaris
- **Criteri de sortida**: tots els casos coberts

### Disseny
- **Consumeix**: proposta aprovada
- **Produeix**: decisions tècniques, arquitectura, components
- **Criteri de sortida**: cap pregunta tècnica oberta

### Tasques
- **Consumeix**: spec + disseny
- **Produeix**: checklist ordenada i implementable
- **Criteri de sortida**: cada tasca és atòmica i verificable

### Apply
- **Consumeix**: tasques + spec + disseny
- **Produeix**: codi implementat, tasques marcades
- **Criteri de sortida**: totes les tasques completades

### Verificació
- **Consumeix**: spec + tasques + apply-progress
- **Produeix**: informe de verificació (CRITICAL / WARNING / SUGGESTION)
- **Criteri de sortida**: sense CRITICAL oberts

### Arxiu
- **Consumeix**: tots els artefactes
- **Produeix**: informe final arxivat
- **Criteri de sortida**: canvi tancat i documentat

---

## INTAKE (landing)

!!! warning "En validació"
    Aquest INTAKE és la **proposta** (`SDD-VD/intake.proposta.md`). Les Parts 1 i 2 s'han provat amb el model local (Qwen3.8 27B al DGX Spark) en execucions repetides; la Part 3 encara no. Els resultats d'aquesta pàgina són d'un sol manual de marca de prova.

INTAKE és la primera fase del flux de landings: converteix el disseny i la marca de VoraStudio en **dades estructurades i confirmades** abans d'escriure una línia d'HTML. Es fa en tres parts, i després de cada una l'agent **para i espera que Pau confirmi**.

**Per què existeix.** Si el model construeix directament a partir d'imatges, "interpreta" el disseny: arrodoneix colors, inventa mides i omple buits amb valors per defecte. INTAKE separa **llegir** el disseny de **construir-lo**, i fa que cada valor que arriba a BUILD hagi passat per la confirmació de Pau.

Les normes que envolten la fase són a [Normes del workflow](workflow/index.md) i [Com estructurem AGENTS.md](workflow/agents-md.md).

### La idea clau: el que es pot mesurar, ho mesura un script

A les primeres proves, el model **llegia** bé els valors però fallava en tot el que és **comparar o mesurar**: aparellava colors pel nom, veia contradiccions que no existien, estimava mides a ull i confonia vores fines. A més, cada execució fallava en una cosa diferent.

La solució que ha funcionat és repartir la feina:

| Qui | Què fa | Per què |
|---|---|---|
| **Scripts** (amb tests) | Llegir el PDF, mesurar colors i components, calcular discrepàncies | És determinista: dona el mateix resultat cada vegada |
| **Model** | Copiar el que diuen els scripts, llegir el que no es pot mesurar (color i pes del text), presentar-ho i parar | És el que fa bé: redactar i explicar |
| **Pau** | Decidir quan el manual es contradiu i confirmar cada part | La decisió no és del model |

```mermaid
graph LR
    P1[Part 1: marca i tokens] -->|Pau confirma| P2[Part 2: components UI]
    P2 -->|Pau confirma| P3[Part 3: seccions i actius]
    P3 -->|Pau confirma| R[intake-result.md]
```

### Entrades

| Entrada | Què conté | Com es llegeix |
|---|---|---|
| `brand.pdf` | Colors, fonts i escala tipogràfica | Com a **text** (el PDF té capa de text) |
| `ui.pdf` | Components: botons, formularis, etiquetes, estats | Com a **imatge** (no té capa de text) |
| Imatges de cada secció | El disseny de la landing | Com a imatge |

Si falta una entrada, l'agent la demana i para. Totes viuen a `SDD-VD/sdd-local/`, que és fora de git: són dades de client. Requisits: `pip install pypdf pymupdf`.

---

### Part 1 — Colors, fonts i escala tipogràfica

**Què fa.** Converteix el manual de marca en un bloc `@theme` de Tailwind v4, amb la tipografia i les discrepàncies del manual.

**Com funciona.** L'agent executa dues ordres, i cap altra eina per llegir el PDF:

```bash
python SDD-VD/scripts/brand_cards.py SDD-VD/sdd-local/brand/brand.pdf   # colors
python SDD-VD/scripts/extract_pdf.py SDD-VD/sdd-local/brand/brand.pdf   # fonts i escala
```

| Pas | Què fa l'agent | Per què |
|---|---|---|
| Colors | Copia la taula, els tokens i els avisos de `brand_cards.py`; no recalcula ni compara | El model comparant colors fallava cada vegada d'una manera diferent |
| `@theme` | Un token per cada variable del manual, amb l'etiqueta del PDF com a comentari (`/* MORAT VIU */`) | L'etiqueta permet traduir després notes com "focus en morat viu" |
| Colors sense token | No entren al `@theme`; es llisten a part | No es pot inventar un nom de token |
| Fonts | Família i pesos **tal com estan escrits**, errates incloses; sense pesos → "no especificat" | El model tendia a "corregir" errates i a afegir un Regular per defecte |
| Rols i escala | Només si el PDF els escriu; si no, "no consta" | En una prova, el model va inventar rols (títol, cos) que el PDF no deia |
| Discrepàncies | Es llisten totes; no se'n tria cap | Decideix Pau |

**Què presenta.** El `@theme` en línia, fonts i pesos, l'escala o "no consta", els avisos de color copiats i les discrepàncies de tipografia. **Para.**

**Resultat de les proves.** Amb aquest flux, 3 de 3 execucions han donat els colors idèntics i correctes: els tokens, els colors sense token a part i els avisos copiats literalment. A la tipografia, 1 de 3 va corregir una errata sense avisar.

#### Script `brand_cards.py`

Llegeix les **targetes de color** del manual (rectangles de color amb el nom i els valors a dins) i les compara de manera determinista.

**Per què agrupa per targeta i no llegeix el text en ordre.** En un manual real, una targeta alta tenia el nom a dalt i els valors 470 px més avall. Llegit en ordre, els valors quedaven sense nom i el model n'endevinava el propietari. L'script assigna cada línia de text al rectangle que la conté.

| Aspecte | Detall |
|---|---|
| Per targeta | Nom, HEX, RGB, CMYK i **color real** del rectangle |
| Tokens | Llegeix les variables (`--nom #HEX`) i la seva etiqueta |
| Avisos que calcula | HEX ≠ RGB · HEX o RGB ≠ color real · valor malmès · mateix HEX a dues targetes · mateix nom amb HEX diferents · mateix HEX amb noms diferents · color sense token · token sense targeta |
| Regla de creuament | Sempre pel HEX, mai pel nom: el manual de prova feia servir el mateix nom per a colors diferents en pàgines diferents |
| Sense targetes | `SENSE_TARGETES` i codi 2: l'agent para, no treu els colors a mà |
| Codis | 0 correcte · 1 `ERROR_LECTURA` · 2 `SENSE_TARGETES` |

#### Script `extract_pdf.py`

Extreu el text del PDF pàgina per pàgina (`pypdf`). A la Part 1 només s'usa per a fonts i escala.

| Codi | Significat |
|---|---|
| 0 | Correcte (una capçalera `--- pN ---` per pàgina) |
| 1 | Fitxer no vàlid → `ERROR_LECTURA` |
| 2 | El PDF no té capa de text → `SENSE_TEXT` (l'agent para) |

---

### Part 2 — Components UI

**Què fa.** Descriu cada component (botons, formularis, targetes, etiquetes, pestanyes) de manera que BUILD el pugui reproduir **fidel a l'original**: forma, farciment, vora, text i mida.

**Per què necessita scripts.** El PDF de components és una imatge. En una prova sense mesures, el model va encertar els colors grans i els radis, però va fer els botons de 48 px quan fan 42, les etiquetes de 32 quan fan 42, i va confondre una vora grisa amb un farciment. Construït així, el resultat es veuria diferent del disseny.

**Com funciona.**

```bash
python SDD-VD/scripts/render_pdf.py SDD-VD/sdd-local/brand/ui.pdf SDD-VD/sdd-local/brand/ui-pages --tokens nom=#HEX ...
python SDD-VD/scripts/ui_metrics.py SDD-VD/sdd-local/brand/ui.pdf --tokens nom=#HEX ...
```

Els tokens són els que Pau ha confirmat a la Part 1.

| Pas | Què fa l'agent | Per què |
|---|---|---|
| Mirar les imatges | Cada component porta una etiqueta amb un ID (`C3`) i el seu token | Per saber quin component és cada línia de mesures |
| Forma, farciment, vora i mida | Les **copia** de la línia de `ui_metrics.py` amb el mateix ID; si hi ha dues classes (`h-10/h-11`), les dues | A ull, el model s'equivocava de manera sistemàtica |
| Text | Color, pes i majúscules, llegits de la imatge | És l'únic que no es mesura |
| Hex | Només els de `ui_metrics.py`, mai els de les etiquetes de la imatge | En una prova, el model va llegir malament una etiqueta petita i va inventar una discrepància |
| Notes escrites | S'assignen al component on apareixen; els colors pel nom es tradueixen amb l'etiqueta del `@theme` | "Morat viu" ha de ser el token amb aquesta etiqueta |
| Nota vs mesura | Si no coincideixen, es llisten tots dos | El manual de prova es contradiu: una nota diu 30 px de radi i el dibuix en fa 23 |
| Estats | Hover, active, focus o disabled que no consten → "no especificat" | No s'inventen |
| Textos | Els textos d'exemple dels components no cal transcriure'ls; s'ignoren només els aliens a la marca | El model va aturar-se una vegada perquè la regla antiga era ambigua |

No es retallen ni es desen altres imatges: només les que genera `render_pdf.py`.

**Què presenta.** Una fitxa per component amb el seu ID, els avisos de color sense token, les discrepàncies i els estats no especificats. **Para.**

**Resultat de les proves.** 3 de 3 execucions han copiat els **23 components** amb forma, farciment, vora i mida idèntics a les mesures, i totes han llistat les discrepàncies entre notes i dibuix. Hi ha errors de **lectura d'imatge** que canvien a cada execució:

- el color o el pes del text d'alguns components;
- errors de transcripció en textos petits;
- traduir el focus "morat viu" al seu token: ho ha fet en 2 de 3 execucions.

#### Script `ui_metrics.py`

Mesura cada component de les pàgines renderitzades i en dona una línia de text:

```text
C4 · x 315 y 344 · 194×43 (w-48/w-49 · h-11) · farciment cap · vora 1.5 purple-700 (border/border-2) · radi full (rounded-full)
```

| Aspecte | Detall |
|---|---|
| Unitats | Píxels del disseny (el PDF es renderitza a 144 dpi, el doble) |
| Farciment i vora | Token més proper o `SENSE_TOKEN #HEX`; una vora grisa es reporta com a vora, no com a farciment |
| Gruix de vora | Mesurat amb la cobertura parcial dels píxels, per no perdre les vores de 0,5-1 px |
| Radi | Ajustat a la corba de la cantonada; `full` si és una píndola |
| Classes | Escala de Tailwind v4, mai valors arbitraris; si la mida cau entre dues classes, dona les dues |
| Niuament | `dins C2` si el component és dins d'un altre (per exemple, els camps dins del formulari) |
| IDs | Globals entre pàgines (C1…Cn), els mateixos que surten a la imatge |
| Codis | 0 correcte · 1 `ERROR_METRIQUES` · 2 `SENSE_COMPONENTS` |
| Temps | Uns 17 s per a dues pàgines |

**Limitació coneguda.** Si la imatge mateixa és ambigua, la mesura també ho és. En el manual de prova, les vores dels camps tenen un gris diferent a cada costat, i el script dona un gris sense token amb `border`. Això és correcte per construir, però no dona un hex exacte.

#### Script `render_pdf.py`

Renderitza cada pàgina a `pN.png` (144 dpi). Amb `--tokens`, escriu damunt de cada regió de color el seu token i, si forma part d'un component, l'ID de `ui_metrics.py` (`C3 purple-700`). Les etiquetes poden tapar una part del text: si una nota no es llegeix bé, l'agent pregunta. Codis: 0 correcte · 1 `ERROR_RENDER`.

`color_regions.py` és el mòdul de base que detecta regions de color i les assigna al token més proper (cap canal RGB a més de 6 de diferència). També es pot executar sol per depurar.

#### Tests

Els scripts `brand_cards.py` i `ui_metrics.py` tenen tests (`unittest`) amb PDF sintètics, sense dades de client. Cada error trobat amb el PDF real té un test que el reprodueix.

```bash
cd SDD-VD/scripts && python -m unittest
```

---

### Part 3 — Seccions i actius

**Què fa.** L'inventari del que cal construir i del que ja tenim: numera les seccions de les imatges, en descriu l'estructura i, per a cada imatge, logo, font i text necessari, indica si **hi és** o **falta**.

**Per què.** Detectar abans de BUILD què falta evita parar a mig bloc.

**Estat.** Definida, però encara no s'ha provat.

---

### Criteris de verificació d'INTAKE

| Comprovació | Criteri |
|---|---|
| Entrades | Existeixen totes; si no, l'agent para |
| Eines | Només les ordres del flux; cap lectura alternativa del PDF ni fitxers propis |
| Valors | Venen dels scripts o del PDF; cap color, font o mida estimats a ull |
| Discrepàncies | Llistades totes, cap resolta en silenci |
| Notació | Cap píxel en text ni valor arbitrari (`text-[22px]`, `rounded-[30px]`) |
| Estats absents | "no especificat", no inventats |
| Aprovació | Pau confirma cada part abans de la següent |
| Resultat | `intake-result.md`, curt i estructurat; BUILD el llegeix |
| Ordre | Cap `index.html` abans de les tres confirmacions |

!!! note "Pendent"
    - Provar la Part 3.
    - Millorar la lectura del text dels components (color i pes).
    - Provar el flux amb un manual de marca diferent: els scripts s'han validat amb un sol format de manual.
    - Definir què es desa exactament a `intake-result.md`.
