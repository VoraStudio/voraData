# Skills — Presets d'agent per a VoraData

> Skills instal·lades globalment i disponibles a OpenCode, Claude Code i qualsevol agent compatible.

---

!!! warning "Stack override obligatori"
    Les skills de disseny estan orientades a React + Framer Motion per defecte.
    Sempre afegeix al primer prompt de sessió:
    ```
    Stack: HTML + Tailwind v4 + Vanilla JS + GSAP. No React, no Framer Motion.
    ```

---

## Taste Skill — `leonxlnx/taste-skill`

El paquet més recomanat per evitar UI genèrica. Corregeix biaixos estadístics dels LLMs cap a patrons de disseny repetitius.

<div class="grid cards" markdown>

-   :material-creation:{ .lg .middle } **design-taste-frontend**

    ---

    El skill base del paquet. Configura tres dials globals que guien totes les decisions visuals:

    - `DESIGN_VARIANCE: 8` — asimetria, masonry, espai negatiu
    - `MOTION_INTENSITY: 6` — transicions fluides, spring physics
    - `VISUAL_DENSITY: 4` — equilibri entre airy i funcional

    Inclou **The Creative Arsenal** — catàleg de 40+ patrons avançats (Bento Grid, SplitScreen, Curtain Reveal, Spotlight Card...) i **AI Tells** — llista negra de patrons prohibits (Inter, 3 cards iguals, gradients de text en headers...).

    **Quan usar-lo:** sempre. Skill base per a totes les sessions de landing o SaaS UI.

    ```
    npx skills add leonxlnx/taste-skill@design-taste-frontend
    ```

-   :material-star-shooting:{ .lg .middle } **high-end-visual-design**

    ---

    Ensenya l'agent a dissenyar com una agència premium. Defineix fonts, espaiat, ombres i estructures de card concretes que fan que una web sembli cara. Bloca tots els defaults que fan que les IAs produeixin disseny barat.

    **Quan usar-lo:** clients amb pressupost alt, webs de portfolio, landings premium.

    ```
    npx skills add leonxlnx/taste-skill@high-end-visual-design
    ```

-   :material-minus-circle-outline:{ .lg .middle } **minimalist-ui**

    ---

    Interfícies d'estil editorial net. Paleta monocroma càlida, contrast tipogràfic, bento grids plans, pastel suau. Sense gradients, sense ombres pesades.

    **Quan usar-lo:** clients corporatius, consultores, professionals liberals (metges, advocats, arquitectes).

    ```
    npx skills add leonxlnx/taste-skill@minimalist-ui
    ```

-   :material-factory:{ .lg .middle } **industrial-brutalist-ui**

    ---

    Interfícies mecàniques crues que fusionen tipografia suïssa d'impremta amb estètica de terminal militar. Graelles rígides, contrast tipogràfic extrem, color utilitari, efectes d'envelliment analògic.

    **Quan usar-lo:** portfolios tècnics, dashboards de dades, sites editorials que han de semblar plànols desclassificats.

    ```
    npx skills add leonxlnx/taste-skill@industrial-brutalist-ui
    ```

-   :material-file-check:{ .lg .middle } **full-output-enforcement**

    ---

    Sobreescriu el comportament de truncament dels LLMs. Força la generació de codi completa, prohibeix patrons de placeholder (`// ... rest of code`) i gestiona splits per límit de tokens de forma neta.

    **Quan usar-lo:** sempre amb el DGX Spark (models locals tendeixen a truncar). Afegir a qualsevol sessió de BUILD.

    ```
    npx skills add leonxlnx/taste-skill@full-output-enforcement
    ```

</div>

---

## Impeccable — `pbakaus/impeccable`

<div class="grid cards" markdown>

-   :material-auto-fix:{ .lg .middle } **impeccable**

    ---

    Skill de revisió i millora d'interfícies frontend. Cobreix disseny visual, jerarquia, accessibilitat, rendiment, responsive, tipografia, color, moviment, micro-interaccions i UX copy.

    Útil tant per polir un disseny existent com per critcar-lo o redissenyar-lo des de zero.

    **Quan usar-lo:** fase DELIVER — revisió final abans de lliurar al client. També per auditar webs existents.

    ```
    npx skills add pbakaus/impeccable@impeccable
    ```

</div>

---

## Com s'activen les skills

Les skills s'activen automàticament quan el trigger coincideix amb la tasca. No cal invocar-les manualment.

Per forçar una skill concreta, menciona-la explícitament al prompt:

```
Using the high-end-visual-design skill, build the hero section for...
```

```
Using full-output-enforcement, generate the complete CSS for...
```

---

## Combinació recomanada per a landings

Per a una sessió de BUILD d'una landing page, les skills s'activaran en ordre:

```
1. design-taste-frontend   → decisions globals de disseny
2. high-end-visual-design  → estil premium (o minimalist-ui per a corporatiu)
3. full-output-enforcement → codi complet sense truncaments
4. impeccable              → revisió final a DELIVER
```
