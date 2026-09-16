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

---

## Web Quality — `addyosmani/web-quality-skills`

Skills de **Addy Osmani** (Google Chrome DevRel). Mapegen directament al checklist de DELIVER de VoraData.

<div class="grid cards" markdown>

-   :material-shield-check:{ .lg .middle } **accessibility**

    ---

    WCAG 2.1 AA: contrast, navegació per teclat, ARIA labels, focus management, rols semàntics. S'activa automàticament en qualsevol component interactiu o formulari.

    **Fase:** DELIVER — verificació final abans de lliurar.

    ```
    npx skills add addyosmani/web-quality-skills@accessibility
    ```

-   :material-magnify:{ .lg .middle } **seo**

    ---

    Meta tags, Open Graph, canonical, estructura de headings, sitemap, schema markup. Cobreix tot el que el checklist de lliurament de VoraData requereix.

    **Fase:** DELIVER — específic de landings i webs públiques.

    ```
    npx skills add addyosmani/web-quality-skills@seo
    ```

-   :material-speedometer:{ .lg .middle } **performance**

    ---

    LCP < 2.5s, CLS < 0.1, optimització d'imatges, lazy loading, JS < 50KB. Mètriques directament del checklist de lliurament de VoraData.

    **Fase:** DELIVER — Lighthouse i Core Web Vitals.

    ```
    npx skills add addyosmani/web-quality-skills@performance
    ```

</div>

---

## Tailwind — `wshobson/agents`

<div class="grid cards" markdown>

-   :material-palette-swatch-variant:{ .lg .middle } **tailwind-design-system**

    ---

    Genera i manté sistemes de disseny en Tailwind v4. Migra configuració a blocs `@theme {}` amb CSS variables natives, colors OKLCH i `@custom-variant` per a dark mode.

    **Verificat per a Tailwind v4** — no usar en projectes v3.

    **Fase:** INTAKE → genera el `@theme {}` a partir dels tokens del client.

    ```
    npx skills add wshobson/agents@tailwind-design-system
    ```

</div>

---

## Combinació recomanada per a landings

Per a una sessió completa de landing page, les skills s'activen per fase:

```
INTAKE
  └── tailwind-design-system  → genera @theme {} amb els tokens del client

BUILD
  ├── design-taste-frontend   → decisions globals de disseny
  ├── high-end-visual-design  → estil premium (o minimalist-ui / industrial-brutalist-ui)
  └── full-output-enforcement → codi complet sense truncaments (crític amb DGX Spark)

DELIVER
  ├── impeccable              → revisió visual final
  ├── accessibility           → WCAG 2.1 AA
  ├── seo                     → meta tags, OG, canonical
  └── performance             → LCP, CLS, Lighthouse
```
